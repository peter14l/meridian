import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.7.1'

serve(async (req) => {
  try {
    const { jobId, type } = await req.json()

    if (!jobId || !type) {
      return new Response(JSON.stringify({ error: 'Missing parameters' }), { status: 400 })
    }

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 })
    }

    const { data: { user } } = await supabaseClient.auth.getUser(authHeader.replace('Bearer ', ''))
    if (!user) return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 })

    // Fetch job application details
    const { data: job } = await supabaseClient.from('job_applications').select('*').eq('id', jobId).single()

    const geminiApiKey = Deno.env.get('GEMINI_API_KEY')
    let emailDraft = `Subject: Following up on ${job?.role || 'Application'}

Hi ${job?.company || 'Team'},

I'm following up on my application for the ${job?.role || 'Role'} position...`

    if (geminiApiKey) {
      const prompt = `You are a professional career coach powered by Gemini 3.1 Pro. 
Draft a polite, high-conversion ${type} email for a student applying to a job.

Company: ${job?.company || 'Unknown'}
Role: ${job?.role || 'Unknown'}
Current Status: ${job?.status || 'Unknown'}

Provide a professional subject line and a concise, compelling email body.`

      const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-pro:generateContent?key=${geminiApiKey}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          contents: [{ parts: [{ text: prompt }] }],
          generationConfig: {
            temperature: 0.7,
            topP: 0.9,
          }
        }),
      })

      const result = await response.json();
      try {
        emailDraft = result.candidates[0].content.parts[0].text;
      } catch (e) {
        console.error("Gemini 3.1 draft error", e);
      }
    }

    // Save draft
    const { data: aiDraft, error } = await supabaseClient.from('ai_drafts').insert({
      user_id: user.id,
      context_type: type,
      context_id: jobId,
      prompt: `Draft a ${type} email with Gemini 3.1 Pro.`,
      response: emailDraft,
      model_used: "gemini-3.1-pro"
    }).select().single()

    if (error) return new Response(JSON.stringify({ error: error.message }), { status: 500 })

    return new Response(JSON.stringify({ draft: emailDraft, ...aiDraft }), { headers: { "Content-Type": "application/json" } })
  } catch (err) {
    return new Response(JSON.stringify({ error: 'Internal Server Error' }), { status: 500 });
  }
})
