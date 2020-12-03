var response = require('../../shared/response');
var TYPES = require('tedious').TYPES;

function AuthorRepository(dbContext) {
    function getAuthors(req, res) {
        dbContext.get("getAuthor", function (error, data) {
            return res.json(response(data, error));
        });
    }
    function getAuthor(req, res) {
        if (req.params.AuthorId) {
            var parameters = [];
            parameters.push({ name: 'Id', type: f.Int, val: req.params.AuthorId });
            var query = "select * from Author where AUTHOR_ID = @Id"
            dbContext.getQuery(query, parameters, false, function (error, data) {
                if (data) {
                    req.data = data[0];
                    return next();
                }
                return res.sendStatus(404);
            });
        } else {
            return res.sendStatus(500);
        }
    }
    function postAuthors(req, res) {
        var parameters = [];
        parameters.push({ name: 'FirstName', type: TYPES.VarChar, val: req.body.FirstName });
        parameters.push({ name: 'LastName', type: TYPES.VarChar, val: req.body.LastName });
        dbContext.post("proc_InsertOrUpdateAuthor", parameters, function (error, data) {
            return res.json(response(data, error));
        });
    }
    return {
        getAll: getAuthors,
        get: getAuthor,
        post: postAuthors
    }
}
module.exports = AuthorRepository;