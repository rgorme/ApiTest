const _authorRepository = require('./author.repository');
const dbContext = require('../../database/dbContext');
module.exports = function (router) {
    const authorRepository = _authorRepository(dbContext);
    router.route('/author')
        .get(authorRepository.getAll)
        .post(authorRepository.post);

    // router.use('/authors/:authorId', authorRepository.intercept);
    // router.route('/authors/:authorId')
    //     .get(authorRepository.get)
    //     .put(authorRepository.put)
    //     .delete(authorRepository.delete);
}