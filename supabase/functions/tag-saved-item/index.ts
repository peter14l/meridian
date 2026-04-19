import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3'

const SUPABASE_URL = Deno.env.get('SUPABASE_URL') ?? ''
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
const GEMINI_API_KEY = Deno.env.get('GEMINI_API_KEY') ?? ''

serve(async (req) => {
  // This function can be called via webhook (INSERT on saved_items) or directly
  const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)
  
  // Check if this is a webhook payload or a direct request
  const contentType = req.headers.get('content-type') || ''
  let record: any = null
  
  if (contentType.includes('application/json')) {
    const payload = await req.json()
    record = payload.record || payload
  }
  
  // If no record from webhook, try to get ID from query params
  const url = new URL(req.url)
  const itemId = url.searchParams.get('id')
  
  if (!record && !itemId) {
    return new Response(JSON.stringify({ error: 'Invalid payload' }), { status: 400, headers: corsHeaders() })
  }

  // Fetch the saved item
  let savedItem: any
  if (record) {
    savedItem = record
  } else if (itemId) {
    const { data } = await supabase.from('saved_items').select('*').eq('id', itemId).single()
    savedItem = data
  }

  if (!savedItem || !savedItem.id) {
    return new Response(JSON.stringify({ error: 'Saved item not found' }), { status: 404, headers: corsHeaders() })
  }

  // If already tagged, skip
  if (savedItem.ai_summary && savedItem.tag) {
    return new Response(JSON.stringify({ success: true, message: 'Already tagged' }), { headers: corsHeaders() })
  }

  // Get user's courses and goals for suggestion
  const userId = savedItem.user_id
  const [coursesRes, goalsRes] = await Promise.all([
    supabase.from('courses').select('id, name').eq('user_id', userId).limit(8),
    supabase.from('goals').select('id, title').eq('user_id', userId).limit(5),
  ])
  
  const courses = coursesRes.data || []
  const goals = goalsRes.data || []

  if (!GEMINI_API_KEY) {
    // Fallback without AI
    return tagWithFallback(savedItem, supabase)
  }

  const prompt = `You are the Meridian Smart Capture Agent powered by Gemini 2.0 Flash.
Analyze the following URL and provide a concise summary, specific tags, and a categorization.

URL: ${savedItem.url}
Title: ${savedItem.title || 'Unknown'}
Description: ${savedItem.description || 'Unknown'}

USER'S COURSES: ${JSON.stringify(courses.map(c => c.name))}
USER'S GOALS: ${JSON.stringify(goals.map(g => g.title))}

Available Categories: article, job, resource, tool, research

INSTRUCTIONS:
1. Provide a 1-sentence intelligent summary of what this content is about
2. List 2-4 relevant tags
3. Choose the best category from the available options
4. If this relates to any of the user's courses or goals, suggest which one

Output ONLY a valid JSON object (no markdown, no code blocks):
{
  "summary": "1-sentence summary",
  "tags": ["tag1", "tag2"],
  "category": "resource",
  "suggested_course_id": "course UUID if relevant, else null",
  "suggested_goal_id": "goal UUID if relevant, else null"
}`

  const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      contents: [{ parts: [{ text: prompt }] }],
      generationConfig: { 
        responseMimeType: "application/json",
        temperature: 0.5,
        maxOutputTokens: 300,
      }
    }),
  })

  let aiResult: any = {}
  
  if (response.ok) {
    const result = await response.json()
    const rawText = result.candidates?.[0]?.content?.parts?.[0]?.text || ''
    try {
      aiResult = JSON.parse(rawText.replace(/```json\n?/g, '').replace(/```\n?/g, '').trim())
    } catch (e) {
      console.error('Failed to parse Gemini response:', rawText)
    }
  }

  // Map AI category to database enum
  const categoryMap: Record<string, string> = {
    'article': 'article',
    'job': 'job',
    'resource': 'resource',
    'tool': 'tool',
    'research': 'research',
  }
  
  const mappedCategory = categoryMap[aiResult.category?.toLowerCase()] || 'resource'

  // Map suggested course/goal names to IDs
  let suggestedCourseId: string | null = null
  let suggestedGoalId: string | null = null
  
  if (aiResult.suggested_course_id && typeof aiResult.suggested_course_id === 'string') {
    const matchedCourse = courses.find(c => c.name.toLowerCase().includes(aiResult.suggested_course_id.toLowerCase()))
    if (matchedCourse) suggestedCourseId = matchedCourse.id
  }
  
  if (aiResult.suggested_goal_id && typeof aiResult.suggested_goal_id === 'string') {
    const matchedGoal = goals.find(g => g.title.toLowerCase().includes(aiResult.suggested_goal_id.toLowerCase()))
    if (matchedGoal) suggestedGoalId = matchedGoal.id
  }

  const { error } = await supabase
    .from('saved_items')
    .update({
      ai_summary: aiResult.summary || 'Saved from the web.',
      ai_tags: aiResult.tags || ['Resource'],
      tag: mappedCategory,
      suggested_course_id: suggestedCourseId,
      suggested_goal_id: suggestedGoalId,
    })
    .eq('id', savedItem.id)

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500, headers: corsHeaders() })
  }

  return new Response(JSON.stringify({ success: true }), { headers: corsHeaders() }
})

async function tagWithFallback(savedItem: any, supabase: any) {
  const { error } = await supabase
    .from('saved_items')
    .update({
      ai_summary: 'Saved from the web.',
      ai_tags: ['Resource'],
      tag: 'resource',
    })
    .eq('id', savedItem.id)

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500, headers: corsHeaders() })
  }
  
  return new Response(JSON.stringify({ success: true, fallback: true }), { headers: corsHeaders() })
}

function corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  }
}