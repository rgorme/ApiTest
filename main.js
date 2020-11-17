const express = require('express');
const app = express();
const host = "0.0.0.0";
const port = 3033;

app.get('/', (req, res) => {
    res.send('Hello World!')
});

app.listen(port, host, () => {
    console.log(`Server now listening on port http://localhost:${port}`)
});