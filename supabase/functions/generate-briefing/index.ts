import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3'

const SUPABASE_URL = Deno.env.get('SUPABASE_URL') ?? ''
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
const GEMINI_API_KEY = Deno.env.get('GEMINI_API_KEY') ?? ''

serve(async (req) => {
  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

  // Authenticate user
  const authHeader = req.headers.get('Authorization')
  if (!authHeader) {
    return new Response(JSON.stringify({ error: 'Missing auth header' }), { status: 401, headers: corsHeaders() })
  }

  const { data: { user }, error: authError } = await supabase.auth.getUser(authHeader.replace('Bearer ', ''))
  if (authError || !user) {
    return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401, headers: corsHeaders() })
  }

  const today = new Date().toISOString().split('T')[0]

  // Idempotency: return existing briefing if one exists for today
  const { data: existingBriefing } = await supabase
    .from('daily_briefings')
    .select('id, content_json')
    .eq('user_id', user.id)
    .eq('date', today)
    .maybeSingle()

  if (existingBriefing) {
    return new Response(JSON.stringify(existingBriefing), { headers: { "Content-Type": "application/json", ...corsHeaders() } })
  }

  // Fetch full context for the briefing
  const [tasksRes, jobsRes, savedItemsRes, coursesRes, goalsRes] = await Promise.all([
    supabase.from('tasks').select('*').eq('user_id', user.id).is('deleted_at', null).neq('status', 'done').order('priority', { ascending: true }).limit(15),
    supabase.from('job_applications').select('*').eq('user_id', user.id).is('deleted_at', null).neq('status', 'rejected').order('created_at', { ascending: false }).limit(10),
    supabase.from('saved_items').select('*').eq('user_id', user.id).is('deleted_at', null).order('created_at', { ascending: false }).limit(10),
    supabase.from('courses').select('*').eq('user_id', user.id).limit(8),
    supabase.from('goals').select('*').eq('user_id', user.id).limit(5),
  ])

  const tasks = tasksRes.data || []
  const jobs = jobsRes.data || []
  const savedItems = savedItemsRes.data || []
  const courses = coursesRes.data || []
  const goals = goalsRes.data || []

  // Identify urgent items
  const now = new Date()
  const threeDaysFromNow = new Date(now.getTime() + 3 * 24 * 60 * 60 * 1000)
  const urgentTasks = tasks.filter(t => t.due_at && new Date(t.due_at) <= threeDaysFromNow)
  const pendingJobActions = jobs.filter(j => {
    if (j.status === 'applied' && j.next_follow_up_at) return new Date(j.next_follow_up_at) <= now
    if (j.status === 'oa' || j.status === 'interview') return true
    return false
  })

  if (!GEMINI_API_KEY) {
    return new Response(JSON.stringify({ error: 'Gemini API key not configured' }), { status: 500, headers: corsHeaders() })
  }

  const prompt = `You are Meridian, an AI student assistant. Generate a personalized morning briefing based on the user's context.

USER CONTEXT:
- Courses: ${JSON.stringify(courses.map(c => c.name))}
- Goals: ${JSON.stringify(goals.map(g => g.title))}

URGENT TASKS (due within 3 days):
${JSON.stringify(urgentTasks.map(t => ({ title: t.title, due: t.due_at, priority: t.priority, course: t.course_id })))}

ALL PENDING TASKS:
${JSON.stringify(tasks.map(t => ({ title: t.title, due: t.due_at, priority: t.priority })))}

JOB APPLICATIONS:
${JSON.stringify(jobs.map(j => ({ company: j.company, role: j.role, status: j.status, appliedAt: j.applied_at })))}

PENDING JOB ACTIONS:
${JSON.stringify(pendingJobActions.map(j => ({ company: j.company, role: j.role, action: j.status === 'applied' ? 'Follow up needed' : 'Interview/OA pending' })))}

RECENTLY SAVED RESOURCES:
${JSON.stringify(savedItems.map(s => ({ title: s.title || s.url, tag: s.tag })))}

INSTRUCTIONS:
1. Write a warm, empathetic insight (max 3 sentences) that connects the user's tasks, jobs, and resources into a coherent narrative. Reference specific items.
2. Identify the top 2-3 most critical actions for today from the urgent tasks.
3. Tone: helpful, encouraging, like a smart friend who knows your schedule — NOT robotic or list-like.
4. If there are no urgent tasks, acknowledge that positively.
5. If there are pending job actions, mention them naturally.

Output ONLY a valid JSON object (no markdown, no code blocks):
{
  "insight": "Your personalized insight here",
  "highlighted_tasks": [
    {"title": "Task title", "priority": 1, "due": "due date if any"}
  ]
}`

  const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: {
        responseMimeType: "application/json",
        temperature: 0.8,
        topP: 0.95,
        maxOutputTokens: 500,
      }
    }),
  })

  if (!response.ok) {
    const errorBody = await response.text()
    console.error('Gemini API error:', errorBody)
    const fallbackContent = generateFallbackBriefing(urgentTasks, pendingJobActions)
    return saveAndReturnBriefing(fallbackContent, supabase, user.id, today)
  }

  const result = await response.json()
  const rawText = result.candidates?.[0]?.content?.parts?.[0]?.text ?? ''

  let generatedContent
  try {
    const cleanText = rawText.replace(/```json\n?/g, '').replace(/```\n?/g, '').trim()
    generatedContent = JSON.parse(cleanText)
  } catch (e) {
    console.error('Failed to parse Gemini response:', rawText)
    generatedContent = generateFallbackBriefing(urgentTasks, pendingJobActions)
  }

  return saveAndReturnBriefing(generatedContent, supabase, user.id, today)
})

function generateFallbackBriefing(urgentTasks: any[], pendingJobActions: any[]) {
  const taskText = urgentTasks.length > 0
    ? `You have ${urgentTasks.length} urgent task${urgentTasks.length > 1 ? 's' : ''} coming up.`
    : 'No urgent deadlines right now — great time to get ahead!'
  const jobText = pendingJobActions.length > 0
    ? ` You also have ${pendingJobActions.length} pending job action${pendingJobActions.length > 1 ? 's' : ''} to attend to.`
    : ''
  return {
    insight: `Good morning! ${taskText}${jobText} Let's focus on what matters most today.`,
    highlighted_tasks: urgentTasks.slice(0, 3).map(t => ({ title: t.title, priority: t.priority, due: t.due })),
  }
}

async function saveAndReturnBriefing(content: any, supabase: any, userId: string, date: string) {
  const { data: briefing, error: insertError } = await supabase
    .from('daily_briefings')
    .insert({ user_id: userId, date, content_json: content })
    .select()
    .single()

  if (insertError) {
    return new Response(JSON.stringify({ error: insertError.message }), { status: 500, headers: corsHeaders() })
  }

  return new Response(JSON.stringify(briefing), { headers: { "Content-Type": "application/json", ...corsHeaders() } })
}

function corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  }
}