parseSort = require('./sort')

intersection = (a, b) ->
  [a, b] = [b, a] if a.length > b.length
  value for value in a when value in b


csv = (string, opt={}) ->
  string = string.toString() if typeof string is 'number'
  return opt.default || [] unless typeof string is 'string'
  if opt.allowed?.length
    all = string.split(',')
    allowed = opt.allowed.reduce (res, field) ->
      if prefix = field.match(/(.*\.)\*$/)
        res.wildcards.push(prefix[1])
      else
        res.fields.push(field)

      res
    , {fields: [], wildcards: []}

    fields = intersection(allowed.fields, all)
    for wildcard in allowed.wildcards
      fields = fields.concat(all.filter (val) -> val.indexOf(wildcard) == 0)

  else
    fields = string.split(',')

  return fields if fields?.length
  return opt.default || []


boolean = (value) ->
  return true if value in [true, 'true', 1, '1', 'yes']
  false


integer = (number, opt={}) ->
  return opt.default || 0 unless number = Math.round(number)
  number = Math.min(number, opt.max) if opt.max?
  number = Math.max(number, opt.min) if opt.min?
  number


positiveInteger = (string, opt={}) ->
  int = integer(string, opt)
  return int if int >= 0
  opt.default || 0


date = (string) ->
  string = Number(string) if /^[0-9\.]*$/.test(string)
  string = new Date(string)
  string if string.getTime()


dateRegex = "([0-9\.]{11,13}|[0-9]{4}-[0-9]{2}-[0-9a-zA-Z:\.]*)"
dateRangeRegex = "#{dateRegex}?-?#{dateRegex}?"
dateRange = (string, formatter=date) ->
  string = string.toString() if typeof string is 'number'
  if typeof string is 'string' && string = string?.match(new RegExp(dateRangeRegex))
    date1 = formatter(string[1])
    date2 = formatter(string[2])

  {
    from: date1
    to: date2
  }


pagination = (opt={}) ->
  limit = positiveInteger opt.limit,
    default: opt.default || 50
    max: opt.max

  if opt.page
    offset = (positiveInteger(opt.page, default: 1) - 1) * limit
  else
    offset = positiveInteger(opt.offset, default: 0)

  {
    offset: offset
    limit: limit
  }


module.exports =
  sort: (string, opts) -> parseSort(opts)(string)
  csv: csv
  boolean: boolean
  integer: integer
  positiveInteger: positiveInteger
  date: date
  dateRange: dateRange
  pagination: pagination
