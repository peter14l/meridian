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

  // Fetch pending tasks
  const { data: tasks } = await supabaseClient
    .from('tasks')
    .select('id, title, due_at, priority')
    .eq('user_id', user.id)
    .eq('status', 'todo')

  // Construct prompt for Anthropic Claude (Mocked)
  const claudeApiKey = Deno.env.get('CLAUDE_API_KEY')
  /* 
   * In a real implementation:
   * const response = await fetch('https://api.anthropic.com/v1/messages', { ... }) 
   */
   
  const generatedBriefing = {
      insight: `You have ${tasks?.length || 0} tasks pending. Review them to stay on track.`,
      highlighted_tasks: tasks?.slice(0, 3) || []
  };

  // Save the briefing
  const { data: briefing, error: insertError } = await supabaseClient.from('daily_briefings').insert({
    user_id: user.id,
    date: new Date().toISOString().split('T')[0],
    content_json: generatedBriefing
  }).select().single()

  if (insertError) {
      return new Response(JSON.stringify({ error: insertError.message }), { status: 500 })
  }

  return new Response(JSON.stringify(briefing), { headers: { "Content-Type": "application/json" } })
})
