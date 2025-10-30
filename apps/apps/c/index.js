// apps/apps/c/index.js
const express = require('express');
const dns = require('node:dns').promises;
const app = express();

const B_HOST = process.env.B_HOST || 'svc-b.mesh-demo.svc.cluster.local';
const B_URL  = `http://${B_HOST}:8080/name`;

app.get('/health', (_req, res) => res.status(200).send('ok'));

async function fetchWithTimeout(url, ms = 8000) {
  const ac = new AbortController();
  const t = setTimeout(() => ac.abort(new Error(`timeout after ${ms}ms`)), ms);
  try {
    const r = await fetch(url, { signal: ac.signal });
    return r;
  } finally {
    clearTimeout(t);
  }
}

app.get('/hello', async (_req, res) => {
  try {
    console.log('[C] B_HOST=', B_HOST, 'B_URL=', B_URL);
    try {
      const x = await dns.lookup(B_HOST);
      console.log('[C] DNS lookup result:', x);
    } catch (e) {
      console.warn('[C] DNS lookup failed:', e.message);
    }

    const r = await fetchWithTimeout(B_URL, 8000);
    if (!r.ok) {
      const body = await r.text().catch(() => '');
      console.error('[C] B returned non-2xx:', r.status, body);
      return res.status(502).send(`Upstream error ${r.status}`);
    }
    const txt = await r.text();
    res.send(`hello (C) ${txt}`);
  } catch (e) {
    console.error('[C] Fetch error:', e.name || e.code, e.message || e);
    res.status(502).send('Oh, failed to reach B ' + B_URL + ' | ' + (e.name || e.code || 'error'));
  }
});

app.listen(8080, '0.0.0.0', () => console.log('C listening on 0.0.0.0:8080'));
