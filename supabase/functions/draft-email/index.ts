import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.3'

const SUPABASE_URL = Deno.env.get('SUPABASE_URL') ?? ''
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
const GEMINI_API_KEY = Deno.env.get('GEMINI_API_KEY') ?? ''

serve(async (req) => {
  try {
    const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)
    
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Missing auth header' }), { status: 401, headers: corsHeaders() })
    }

    const { data: { user }, error: authError } = await supabase.auth.getUser(authHeader.replace('Bearer ', ''))
    if (authError || !user) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401, headers: corsHeaders() })
    }

    const { jobId, type } = await req.json()

    if (!jobId || !type) {
      return new Response(JSON.stringify({ error: 'Missing parameters: jobId and type required' }), { status: 400, headers: corsHeaders() })
    }

    // Fetch job application details
    const { data: job, error: jobError } = await supabase
      .from('job_applications')
      .select('*')
      .eq('id', jobId)
      .eq('user_id', user.id)
      .single()

    if (jobError || !job) {
      return new Response(JSON.stringify({ error: 'Job application not found' }), { status: 404, headers: corsHeaders() })
    }

    // Fetch user's resume summary if available
    const { data: primaryResume } = await supabase
      .from('resume_versions')
      .select('label')
      .eq('user_id', user.id)
      .eq('is_primary', true)
      .maybeSingle()

    let emailDraft = ''
    let modelUsed = 'fallback'

    if (GEMINI_API_KEY) {
      const prompt = `You are a professional career coach powered by Gemini 2.0 Flash. 
Draft a polite, high-conversion ${type} email for a student applying to a job.

Company: ${job.company}
Role: ${job.role}
Location: ${job.location || 'Not specified'}
Current Status: ${job.status}
Job URL: ${job.job_url || 'Not available'}
Notes: ${job.notes || 'None'}
Resume: ${primaryResume?.label || 'Not specified'}

Email Type: ${type}
- "followup": Follow up on an already applied position, express continued interest
- "cold": Cold outreach to express interest in a position
- "thankyou": Thank you after an interview

INSTRUCTIONS:
1. Write a professional subject line
2. Write a concise, compelling email body (150-200 words)
3. Include a clear call-to-action
4. Sign off professionally as "[Your Name]"
5. Make it sound human, not robotic

Output ONLY valid JSON (no markdown, no code blocks):
{
  "subject": "Your professional subject line here",
  "body": "Your email body here"
}`

      const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${GEMINI_API_KEY}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          contents: [{ parts: [{ text: prompt }] }],
          generationConfig: {
            responseMimeType: "application/json",
            temperature: 0.7,
            maxOutputTokens: 600,
          }
        }),
      })

      if (response.ok) {
        const result = await response.json()
        const rawText = result.candidates?.[0]?.content?.parts?.[0]?.text || ''
        try {
          const parsed = JSON.parse(rawText.replace(/```json\n?/g, '').replace(/```\n?/g, '').trim())
          emailDraft = `Subject: ${parsed.subject}\n\n${parsed.body}`
          modelUsed = 'gemini-2.0-flash'
        } catch (e) {
          console.error('Failed to parse Gemini response:', rawText)
        }
      }
    }

    // Fallback if no AI or AI failed
    if (!emailDraft) {
      const templates: Record<string, { subject: string; body: string }> = {
        followup: {
          subject: `Following up on ${job.role} Application`,
          body: `Dear Hiring Manager at ${job.company},

I hope this email finds you well. I wanted to follow up on my application for the ${job.role} position I submitted recently.

I remain very excited about the opportunity to contribute to ${job.company} and believe my skills in ${job.role.split(' ')[0] || 'the relevant area'} would be a great fit for your team.

I would love to discuss any updates regarding the hiring timeline or if there are any additional materials I can provide.

Thank you for your consideration.

Best regards`
        },
        cold: {
          subject: `Expressing Interest in ${job.role} Opportunities at ${job.company}`,
          body: `Dear Hiring Manager at ${job.company},

I hope this message finds you well. I came across ${job.company} and am very impressed by the work your team is doing in the industry.

I am currently exploring opportunities and would love to learn more about any open ${job.role} positions that might be a good match for my background.

With my skills and enthusiasm, I believe I could contribute meaningfully to your team. I would welcome the opportunity to discuss how I might support your goals.

Thank you for your time and consideration.

Best regards`
        },
        thankyou: {
          subject: `Thank You for the Interview - ${job.role}`,
          body: `Dear ${job.company} Team,

Thank you for taking the time to meet with me today to discuss the ${job.role} position. I truly enjoyed learning more about the role and your team.

Our conversation reinforced my excitement about the opportunity to join ${job.company} and contribute to your continued success.

Please don't hesitate to reach out if you need any additional information. I look forward to hearing from you.

Best regards`
        }
      }
      
      const template = templates[type] || templates.followup
      emailDraft = `Subject: ${template.subject}\n\n${template.body}`
      modelUsed = 'template'
    }

    // Save the draft
    const { data: aiDraft, error: insertError } = await supabase
      .from('ai_drafts')
      .insert({
        user_id: user.id,
        context_type: type,
        context_id: jobId,
        prompt: `Draft a ${type} email with Gemini 2.0 Flash`,
        response: emailDraft,
        model_used: modelUsed,
        tokens_used: type.length * 10, // Rough estimate
      })
      .select()
      .single()

    if (insertError) {
      console.error('Failed to save AI draft:', insertError)
    }

    return new Response(JSON.stringify({ 
      draft: emailDraft,
      model: modelUsed,
      jobId: job.id,
      company: job.company,
    }), { headers: { "Content-Type": "application/json", ...corsHeaders() } })

  } catch (err) {
    console.error('Error in draft-email function:', err)
    return new Response(JSON.stringify({ error: 'Internal Server Error' }), { status: 500, headers: corsHeaders() })
  }
})

function corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  }
}