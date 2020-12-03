var Connection = require('tedious').Connection;

var config = {
    server: 'sql01',
    authentication: {
        type: 'default',
        options: {
            userName: 'docker',
            password: 'docker'
        }
    },
    options: {
        database: 'LIBRARY',
        rowCollectionOnDone: true,
        useColumnNames: false,
        encrypt: false,
    }
}

var connection = new Connection(config);

connection.on('connect', function (err) {
    if (err) {
        console.log(err);
    } else {
        console.log('Connected');
    }
});

module.exports = connection;