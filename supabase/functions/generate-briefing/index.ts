import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.7.1'

serve(async (req) => {
  const supabaseClient = createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_ANON_KEY') ?? ''
  )
  
  const authHeader = req.headers.get('Authorization')
  if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Missing auth header' }), { status: 401 })
  }
  
  const { data: { user }, error: authError } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
  if (authError || !user) {
    return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 })
  }

  const today = new Date().toISOString().split('T')[0]

  // Deduplication logic
  const { data: existingBriefing } = await supabaseClient
    .from('daily_briefings')
    .select('id, content_json')
    .eq('user_id', user.id)
    .eq('date', today)
    .maybeSingle()

  if (existingBriefing) {
    return new Response(JSON.stringify(existingBriefing), { headers: { "Content-Type": "application/json" } })
  }

  // Fetch Full Context
  const [tasksRes, jobsRes, savedItemsRes] = await Promise.all([
    supabaseClient.from('tasks').select('*').eq('user_id', user.id).eq('status', 'todo').limit(15),
    supabaseClient.from('job_applications').select('*').eq('user_id', user.id).neq('status', 'rejected').limit(10),
    supabaseClient.from('saved_items').select('*').eq('user_id', user.id).order('created_at', { ascending: false }).limit(10)
  ])

  const tasks = tasksRes.data || []
  const jobs = jobsRes.data || []
  const savedItems = savedItemsRes.data || []

  const geminiApiKey = Deno.env.get('GEMINI_API_KEY')
  if (!geminiApiKey) {
    return new Response(JSON.stringify({ error: 'Gemini API Key missing' }), { status: 500 })
  }

  const prompt = `You are Meridian, a state-of-the-art AI student assistant powered by Gemini 3.1 Pro. 
Your goal is to provide a deeply personalized, proactive morning briefing.

Context:
- Tasks Pending: ${JSON.stringify(tasks.map(t => ({ title: t.title, due: t.due_at, priority: t.priority })))}
- Job Search Progress: ${JSON.stringify(jobs.map(j => ({ company: j.company, role: j.role, status: j.status })))}
- Recently Captured Resources: ${JSON.stringify(savedItems.map(s => ({ title: s.title, url: s.url })))}

Instructions:
1. Write a warm, brief (max 3 sentences) insight that connects these pieces of information. 
2. Identify the top 2-3 most critical actions for today.
3. Use a tone that is helpful and empathetic, not just a list.

Output strictly as a VALID JSON object:
{
  "insight": "...",
  "highlighted_tasks": [{"title": "...", "priority": 1}]
}`

  const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-pro:generateContent?key=${geminiApiKey}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: {
        responseMimeType: "application/json",
        temperature: 0.8,
        topP: 0.95,
      }
    }),
  })

  const result = await response.json()
  
  if (!result.candidates || result.candidates.length === 0) {
    console.error("Gemini Error:", result);
    return new Response(JSON.stringify({ error: "Gemini 3.1 Pro generation failed" }), { status: 500 });
  }

  let generatedContent;
  try {
    const rawText = result.candidates[0].content.parts[0].text;
    generatedContent = JSON.parse(rawText);
  } catch (e) {
    generatedContent = {
      insight: "Good morning! You've got this. Let's focus on your top priorities for today.",
      highlighted_tasks: tasks.slice(0, 2).map(t => ({ title: t.title, priority: t.priority }))
    };
  }

  const { data: briefing, error: insertError } = await supabaseClient.from('daily_briefings').insert({
    user_id: user.id,
    date: today,
    content_json: generatedContent
  }).select().single()

  if (insertError) return new Response(JSON.stringify({ error: insertError.message }), { status: 500 })

  return new Response(JSON.stringify(briefing), { headers: { "Content-Type": "application/json" } })
})
