import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.7.1'

serve(async (req) => {
  try {
    const payload = await req.json();
    const record = payload.record;

    if (!record || !record.id || !record.url) {
      return new Response(JSON.stringify({ error: 'Invalid payload' }), { status: 400 });
    }

    const supabaseClient = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '' // Service role to bypass RLS
    );

    // AI Mock Logic (Would connect to Anthropic Claude via fetch)
    const aiSummary = "An excellent resource covering advanced concepts relevant to your current goals.";
    const aiTags = ["Tech", "Tutorial"];
    
    // Update the inserted record with AI enrichments
    const { error } = await supabaseClient
      .from('saved_items')
      .update({
        ai_summary: aiSummary,
        ai_tags: aiTags,
        tag: 'resource'
      })
      .eq('id', record.id);

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), { status: 500 });
    }

    return new Response(JSON.stringify({ success: true }), { headers: { "Content-Type": "application/json" } });
  } catch (err) {
    return new Response(JSON.stringify({ error: 'Internal Server Error' }), { status: 500 });
  }
})
