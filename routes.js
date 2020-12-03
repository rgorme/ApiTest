const express = require('express');
function eRoutes() {
    const router = express.Router();
    var author = require('./repository/author/author.routes')(router);
    return router;
}
module.exports = eRoutes;