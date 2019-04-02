parse = require('./parsers')
parseSort = require('./sort')

exports.all = ({sort: sortOpts, pagination, fields}={}) ->
  sort = sortOpts && parseSort(sortOpts)

  (req, res, next) ->
    q = req.query
    req.options ||= {}
    if sortOpts
      req.options.sort = sort(q.sort)
      delete q.sort

    if pagination
      page = parse.pagination
        page: q.page
        offset: q.offset
        limit: q.limit
        default: pagination.default || 50
        max: pagination.limit || 100

      req.options.offset = page.offset
      req.options.limit = page.limit

      delete q.page
      delete q.offset
      delete q.limit

    if fields
      req.options.fields = parse.csv(q.fields, fields)
      delete q.fields

    next()


exports.sort = (conf) ->
  exports.all({sort: conf})


exports.pagination = (conf) ->
  exports.all({pagination: conf})


exports.fields = (conf) ->
  exports.all({fields: conf})
