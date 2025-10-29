const express = require('express');
const app = express();

app.get('/name', (_req, res) => res.send('service B'));
app.get('/hello', (_req, res) => res.send('hello B'));

app.listen(8080, () => console.log('B listening on 8080'));
