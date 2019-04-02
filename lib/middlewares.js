const parse = require('./parsers')
const parseSort = require('./sort')

module.exports = {
  all: all,
  sort (c) { return all({sort: c}) },
  pagination (c) { return all({pagination: c}) },
  fields (c) { return all({fields: c}) }
}

function all (opts) {
  const sort = opts.sort && parseSort(opts.sort)
  const pagination = opts.pagination
  const fields = opts.fields
  const disabled = !!(sort || pagination || fields)

  return function coercionMiddleware (req, res, next) {
    const options = req.options || Object.create(null)
    if (!disabled) return next()

    const q = req.query
    if (sort) {
      options.sort = sort(q.sort)
      delete q.sort
    }

    if (pagination) {
      const page = parse.pagination({
        page: q.page,
        offset: q.offset,
        limit: q.limit,
        default: pagination.default || 50,
        max: pagination.limit || 100
      })

      options.offset = page.offset
      options.limit = page.limit

      delete q.page
      delete q.offset
      delete q.limit
    }

    if (fields) {
      options.fields = parse.csv(q.fields, fields)
      delete q.fields
    }

    req.options = options
    next()
  }
}
