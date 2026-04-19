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

  // Parse request body
  const { totalHours, focusTopics, currentLevel, preferredTime } = await req.json()

  if (!totalHours || !focusTopics || !Array.isArray(focusTopics)) {
    return new Response(JSON.stringify({ error: 'Missing required parameters: totalHours, focusTopics (array)' }), { status: 400, headers: corsHeaders() })
  }

  // Fetch user's courses and active tasks for context
  const [coursesRes, tasksRes, studySessionsRes] = await Promise.all([
    supabase.from('courses').select('id, name').eq('user_id', user.id).limit(5),
    supabase.from('tasks').select('*').eq('user_id', user.id).is('deleted_at', null).neq('status', 'done').order('priority', { ascending: true }).limit(10),
    supabase.from('study_sessions').select('*').eq('user_id', user.id).order('created_at', { ascending: false }).limit(20),
  ])

  const courses = coursesRes.data || []
  const tasks = tasksRes.data || []
  const pastSessions = studySessionsRes.data || []

  // Calculate average session length from past sessions
  const avgSessionLength = pastSessions.length > 0
    ? pastSessions.reduce((sum: number, s: any) => sum + (s.duration_minutes || 0), 0) / pastSessions.length
    : 25

  // Get user's preferred study time from profile
  const { data: userProfile } = await supabase.from('users').select('wake_time').eq('id', user.id).maybeSingle()
  const userWakeTime = userProfile?.wake_time || '08:00'
  const userSleepTime = '23:00'

  if (!GEMINI_API_KEY) {
    // Fallback: generate basic study plan without AI
    return generateFallbackPlan(totalHours, focusTopics, avgSessionLength)
  }

  const prompt = `You are an AI Study Session Planner for a student app called Meridian.

USER CONTEXT:
- Available study time: ${totalHours} hours
- Focus topics: ${JSON.stringify(focusTopics)}
- Current level: ${currentLevel || 'intermediate'}
- Preferred study time: ${preferredTime || 'morning'}
- User's wake time: ${userWakeTime}
- User's sleep time: ${userSleepTime}
- Past average session length: ${Math.round(avgSessionLength)} minutes
- Enrolled courses: ${JSON.stringify(courses.map((c: any) => c.name))}
- Pending tasks related to study: ${JSON.stringify(tasks.slice(0, 5).map((t: any) => t.title))}

INSTRUCTIONS:
1. Create a study session plan distributed across the next 2 days
2. Include variety: mix deep work (longer sessions), quick reviews, and breaks
3. Suggest specific topics to study based on the focus topics provided
4. Account for the user's preferred time of day
5. Include break recommendations using Pomodoro-style intervals (25-50 min work, 5-10 min break)

Output ONLY a valid JSON object (no markdown, no code blocks):
{
  "sessions": [
    {
      "day": "today" or "tomorrow",
      "time": "HH:MM format",
      "duration_minutes": number,
      "topic": "specific topic name",
      "type": "deep_work" or "quick_review" or "practice",
      "break_after": number (minutes),
      "notes": "optional brief note"
    }
  ],
  "total_study_time": number,
  "focus_areas": ["area1", "area2"],
  "tip": "one sentence motivation/tip"
}`

  const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: {
        responseMimeType: "application/json",
        temperature: 0.7,
        maxOutputTokens: 1500,
      }
    }),
  })

  if (!response.ok) {
    console.error('Gemini API error:', await response.text())
    return generateFallbackPlan(totalHours, focusTopics, avgSessionLength)
  }

  const result = await response.json()
  const rawText = result.candidates?.[0]?.content?.parts?.[0]?.text ?? ''

  let plan
  try {
    plan = JSON.parse(rawText.replace(/```json\n?/g, '').replace(/```\n?/g, '').trim())
  } catch (e) {
    console.error('Failed to parse Gemini response:', rawText)
    return generateFallbackPlan(totalHours, focusTopics, avgSessionLength)
  }

  // Save the generated plan as a study session suggestion
  const { data: savedPlan, error: saveError } = await supabase
    .from('study_sessions')
    .insert({
      user_id: user.id,
      topic: focusTopics[0] || 'General Study',
      duration_minutes: plan.total_study_time || totalHours * 60,
      session_type: 'planned',
      notes: JSON.stringify(plan),
    })
    .select()
    .single()

  return new Response(JSON.stringify({ plan, saved_plan_id: savedPlan?.id }), { headers: { "Content-Type": "application/json", ...corsHeaders() } })
})

function generateFallbackPlan(totalHours: number, focusTopics: string[], avgSessionLength: number) {
  const sessions = []
  const totalMinutes = totalHours * 60
  const sessionLength = Math.min(Math.max(avgSessionLength, 25), 50)
  const numSessions = Math.floor(totalMinutes / (sessionLength + 10))

  for (let i = 0; i < numSessions; i++) {
    const isMorning = i < numSessions / 2
    const hour = isMorning ? 9 + Math.floor(i * 2) : 14 + Math.floor((i - numSessions / 2) * 2)
    sessions.push({
      day: i < numSessions / 2 ? 'today' : 'tomorrow',
      time: `${Math.min(hour, 22).toString().padStart(2, '0')}:00`,
      duration_minutes: sessionLength,
      topic: focusTopics[i % focusTopics.length] || 'Study',
      type: i % 3 === 0 ? 'deep_work' : 'practice',
      break_after: 10,
    })
  }

  return {
    sessions,
    total_study_time: totalMinutes,
    focus_areas: focusTopics.slice(0, 3),
    tip: 'Start with your weakest topic when your mind is freshest!',
  }
}

function corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  }
}