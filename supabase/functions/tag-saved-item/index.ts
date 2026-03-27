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
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    );

    const geminiApiKey = Deno.env.get('GEMINI_API_KEY')
    let aiSummary = "Saved from the web.";
    let aiTags = ["Resource"];
    let tag = "resource";

    if (geminiApiKey) {
      const prompt = `You are the Meridian Smart Capture Agent powered by Gemini 3.1 Pro. 
Analyze the following URL and provide a concise summary, specific tags, and a categorization.

URL: ${record.url}
Title: ${record.title || 'Unknown'}
Description: ${record.description || 'Unknown'}

Available Categories: article, job, resource, tool, research

Output strictly as a VALID JSON object:
{
  "summary": "1-sentence intelligent summary",
  "tags": ["Tag1", "Tag2"],
  "category": "article"
}`

      const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-pro:generateContent?key=${geminiApiKey}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          contents: [{ parts: [{ text: prompt }] }],
          generationConfig: { 
            responseMimeType: "application/json",
            temperature: 0.5 
          }
        }),
      })

      const result = await response.json();
      try {
        const rawText = result.candidates[0].content.parts[0].text;
        const aiResult = JSON.parse(rawText);
        aiSummary = aiResult.summary;
        aiTags = aiResult.tags;
        tag = aiResult.category;
      } catch (e) {
        console.error("Gemini 3.1 parse error", e);
      }
    }

    const { error } = await supabaseClient
      .from('saved_items')
      .update({
        ai_summary: aiSummary,
        ai_tags: aiTags,
        tag: tag
      })
      .eq('id', record.id);

    if (error) return new Response(JSON.stringify({ error: error.message }), { status: 500 });

    return new Response(JSON.stringify({ success: true }), { headers: { "Content-Type": "application/json" } });
  } catch (err) {
    return new Response(JSON.stringify({ error: 'Internal Server Error' }), { status: 500 });
  }
})
