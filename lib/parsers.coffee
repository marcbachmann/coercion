_ = require('lodash')

sort = (string, defaultSort) ->
  string = defaultSort if typeof string != 'string' || !string.length
  return {} unless string?.length

  result = {}
  for s in string.split(',')
    [s, op, key] = s.trim().match(/^([-]?)(.*)/)
    if key
      result[key] = if op == '-' then 'desc' else 'asc'

  result


csv = (string, defaultFields=[], allowedFields) ->
  string = String(string) if typeof string is 'number'
  return defaultFields unless typeof string is 'string'
  fields = _.intersection(allowedFields, string.split(','))
  return fields if fields?.length
  return defaultFields


integer = (string, defaultValue=0, maximum) ->
  Math.min(parseInt(string) || defaultValue, parseInt(maximum) || Infinity)


positiveInteger = (string, defaultValue=0, maximum) ->
  Math.abs(integer(string, defaultValue, maximum))


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


pagination = ({page, offset, limit, defaultLimit, maxLimit}={}) ->
  limit = positiveInteger(limit, defaultLimit || 50, maxLimit)
  if page
    offset = (positiveInteger(page, 1) - 1) * limit
  else
    offset = positiveInteger(offset, 0)

  {
    offset: offset
    limit: limit
  }


module.exports =
  sort: sort
  csv: csv
  integer: integer
  positiveInteger: positiveInteger
  date: date
  dateRange: dateRange
  pagination: pagination
