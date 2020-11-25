const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const app = express();

const port = 3033;

let books = [];

app.use(cors());

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.post('/book', (req, res) => {
    const book = req.body;

    console.log(book);
    books.push(book);
});

app.listen(port, () => {
    console.log(`Server now listening on port http://${host}:${port}`)
});