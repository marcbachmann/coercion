const parsers = require('./lib/parsers')
const middlewares = require('./lib/middlewares')

module.exports = {
  sort: parsers.sort,
  csv: parsers.csv,
  fields: parsers.csv,
  boolean: parsers.boolean,
  integer: parsers.integer,
  positiveInteger: parsers.positiveInteger,
  date: parsers.date,
  dateRange: parsers.dateRange,
  pagination: parsers.pagination,
  middlewares: middlewares
}
