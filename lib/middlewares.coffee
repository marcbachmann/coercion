parse = require('./parsers')

exports.sort = (conf) ->
  (req, res, next) ->
    req.options ||= {}
    req.options.sort = parse.sort(req.query.sort)
    delete req.query.sort
    next()


exports.pagination = (conf) ->
  (req, res, next) ->
    req.options ||= {}
    {offset:req.options.offset, limit:req.options.limit} = parse.pagination
      page: req.query.page
      offset: req.query.offset
      limit: req.query.limit
      defaultLimit: 50
      maxLimit: 100

    delete req.query.page
    delete req.query.offset
    delete req.query.limit
    next()


exports.fields = (conf) ->
  (req, res, next) ->
    req.options ||= {}
    req.options.fields = parse.csv(req.query.fields, conf.default, conf.items)
    delete req.query.fields
    next()
