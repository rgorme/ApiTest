const _authorRepository = require('./author.repository');
const dbContext = require('../../database/dbContext');
module.exports = function (router) {
    const authorRepository = _authorRepository(dbContext);
    router.route('/authors')
        .get(authorRepository.getAll)
        .post(authorRepository.post);

    router.route('/authors/department')
        .get(authorRepository.getMulti);
    router.use('/authors/:authorId', authorRepository.intercept);
    router.route('/authors/:authorId')
        .get(authorRepository.get)
        .put(authorRepository.put)
        .delete(authorRepository.delete);
}