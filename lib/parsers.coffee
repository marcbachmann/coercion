intersection = (a, b) ->
  [a, b] = [b, a] if a.length > b.length
  value for value in a when value in b


sort = (string, opt={}) ->
  opt.ascValue = if opt.ascValue? then opt.ascValue else 'asc'
  opt.descValue = if opt.descValue? then opt.descValue else 'desc'

  string = opt.default if typeof string != 'string' || !string.length
  return {} unless string?.length

  result = {}
  for s in string.split(',')
    [s, op, key] = s.trim().match(/^([-]?)(.*)/)
    isValid = if opt.allowed then key in opt.allowed else true
    if key && isValid
      result[key] = if op == '-' then opt.descValue else opt.ascValue

  result


csv = (string, opt={}) ->
  opt.default ||= []
  string = String(string) if typeof string is 'number'
  return opt.default unless typeof string is 'string'
  if opt.allowed?.length
    fields = intersection(opt.allowed, string.split(','))
  else
    fields = string.split(',')
  return fields if fields?.length
  return opt.default


boolean = (value) ->
  return true if value in [true, 'true', 1, '1', 'yes']
  false


integer = (number, opt={}) ->
  opt.default = 0 if opt.default == undefined || opt.default == null
  return opt.default unless number = parseInt(number)
  number = Math.min(number, opt.max) if opt.max != undefined
  number = Math.max(number, opt.min) if opt.min != undefined
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
  string = String(string) if typeof string is 'number'
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
  sort: sort
  csv: csv
  boolean: boolean
  integer: integer
  positiveInteger: positiveInteger
  date: date
  dateRange: dateRange
  pagination: pagination
