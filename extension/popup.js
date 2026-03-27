document.getElementById('saveBtn').addEventListener('click', async () => {
  const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
  document.getElementById('saveBtn').disabled = true;
  document.getElementById('status').innerText = 'Saving...';
  
  chrome.runtime.sendMessage({ action: 'SAVE_URL', url: tab.url, title: tab.title }, (response) => {
    if (response.success) {
      document.getElementById('status').innerText = 'Saved dynamically!';
    } else {
      document.getElementById('status').innerText = 'Failed to save.';
    }
  });
});
