const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { response } = require('express');
const app = express();

const port = 3033;

app.listen(port, () => {
    console.log(`Server now listening on port http://0.0.0.0:${port}`)
});

app.get('/', (req, res) => {
    res.send('Hello World! I am here')
})

let books = [];

app.use(cors());

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var router = require('./routes')();
 
app.use('/api', router);