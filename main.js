const express = require('express');
const app = express();
const host = "192.168.5.12";
const port = 3033;

app.get('/', (req, res) => {
    res.send('Hello World! I am here')
});

app.listen(port, host, () => {
    console.log(`Server now listening on port http://${host}:${port}`)
});