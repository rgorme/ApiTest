const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { response } = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hello World! I am here')
})

let books = [];

app.use(cors());

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.post('/book', (req, res) => {
    const book = req.body;

    console.log(book);
    books.push(book);
});

app.get('/book', (req, res) => {
    console.log("Hit Book!");
    res.send("Hit book!");
});

app.listen(port, () => {
    console.log(`Server now listening on port http://0.0.0.0:${port}`)
});