const express = require('express');
const fetch = require('node-fetch'); // v2
const app = express();

const B_HOST = process.env.B_HOST || 'svc-b.mesh-demo.svc.cluster.local';
const B_URL = `http://${B_HOST}:8080/name`;

app.get('/hello', async (_req, res) => {
  try {
    const r = await fetch(B_URL, { timeout: 3000 });
    const txt = await r.text();
    res.send(`hello ${txt}`);
  } catch (e) {
    res.status(502).send('failed to reach B');
  }
});

// ---- health endpoint that never calls another service ----
app.get('/health', (_req, res) => res.status(200).send('ok'));

app.listen(8080, () => console.log('A listening on 8080'));
