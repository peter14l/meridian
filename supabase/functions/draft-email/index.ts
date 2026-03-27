import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.7.1'

serve(async (req) => {
  try {
    const { jobId, contextType } = await req.json()

    if (!jobId || !contextType) {
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
    
    if (!user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 })
    }

    // Fetch job application details
    const { data: job } = await supabaseClient.from('job_applications').select('*').eq('id', jobId).single()

    // Mock Anthropic Claude output
    const emailDraft = `Subject: Checking in - ${job?.role || 'Role'} Application at ${job?.company || 'Company'}

Hi Hiring Team,

I'm following up on my application for the ${job?.role || 'Role'} position...`

    // Save draft
    const { data: aiDraft, error } = await supabaseClient.from('ai_drafts').insert({
      user_id: user.id,
      context_type: contextType, // followup
      context_id: jobId,
      prompt: "Draft a follow up email.",
      response: emailDraft,
      model_used: "claude-3-sonnet"
    }).select().single()

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), { status: 500 })
    }

    return new Response(JSON.stringify(aiDraft), { headers: { "Content-Type": "application/json" } })
  } catch (err) {
    return new Response(JSON.stringify({ error: 'Internal Server Error' }), { status: 500 })
  }
})
