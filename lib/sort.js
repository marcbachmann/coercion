const wildcardRegExp = /\.\*$/

module.exports = function parseSort (opt = {}) {
  const ascValue = opt.ascValue || 'asc'
  const descValue = opt.descValue || 'desc'

  const allowed = {}
  const wildcards = {}
  const hasWhiteList = !!opt.allowed
  for (const allow of opt.allowed || []) {
    if (wildcardRegExp.test(allow)) wildcards[allow.replace(wildcardRegExp, '.')] = true
    else allowed[allow] = true
  }

  const hasWildcards = Object.keys(wildcards).length

  return function sort (string) {
    if (typeof string !== 'string' || !string.length) {
      string = opt.default
    }

    const result = {}

    if (!string) return result

    for (const raw of string.split(',')) {
      const [s, op, key] = raw.trim().match(/^([-]?)(.*)/) // eslint-disable-line no-unused-vars
      if (allowed[key]) {
        result[key] = op === '-' ? descValue : ascValue
      } else if (hasWildcards) {
        for (const wildcard in wildcards) {
          if (key.indexOf(wildcard) === 0) {
            result[key] = op === '-' ? descValue : ascValue
            break
          }
        }
      } else if (!hasWhiteList) {
        result[key] = op === '-' ? descValue : ascValue
      }
    }

    return result
  }
}
