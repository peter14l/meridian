chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if (request.action === 'SAVE_URL') {
    // Future: POST request to Supabase DB/Edge Function to trigger `tag-saved-item` webhook
    setTimeout(() => {
        sendResponse({ success: true });
    }, 500);
    return true; // Keep message channel open for async response
  }
});
