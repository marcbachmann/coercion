# Coercion
## A node.js module for type coercion.

# Usage
    
    parse = require('coercion')
    parse.dateRange("2014-01-01-2014-06-01")
    
    {
      from: Wed Jan 01 2014 01:00:00 GMT+0100 (CET),
      to: Sun Jun 01 2014 02:00:00 GMT+0200 (CEST)
    }


## Functions

### sort

    parse.sort('-created,title')

    {
      created: 'desc',
      title: 'asc'
    }


### csv

    parse.csv('allowed,created,title,notallowed', {allowed: ['allowed', 'created', 'title']})

    [ 'allowed', 'created', 'title' ]


### boolean
Always returns a boolean. Default value is false

    // returns true for true, 'true', 1, '1', 'yes'
    parse.boolean('1')

    > true


    parse.boolean('0')

    > false


### integer
Always returns a number. Default value is 0

	// always returns a number
	parse.integer('foo')
	
	> 0

	// Use a default value
	parse.integer('foo', {default: 10})

	> 10


	// Use a maxium value
	parse.integer(1000, {default: 10, max: 100})

	> 100


### positiveInteger
Always returns a number. Default value is 0

	// parse.positiveInteger(number as string or int, default, max value)
	parse.positiveInteger(req.query.limit, {default: 10, max: 100})

	> 100


### date
Always returns a date. Undefined if parsing failed.

    parse.date("2014-01-01")

    Wed Jan 01 2014 01:00:00 GMT+0100 (CET)


### dateRange
Always returns an Object.

    parse.dateRange("2014-01-01-2014-06-01")

    {
      from: Wed Jan 01 2014 01:00:00 GMT+0100 (CET),
      to: Sun Jun 01 2014 02:00:00 GMT+0200 (CEST)
    }


### pagination
Always returns an Object. Default limit is 50

    parse.pagination({page: '10'})

    {
      offset: 450,
      limit: 50
    }


    // Override the offset
    parse.pagination({offset: 450})

    {
      offset: 450,
      limit: 50
    }


    // Set the limit
    parse.pagination({page: 5, limit: 10})

    { offset: 40, limit: 10 }


## middlewares
    parse.middlewares.all(config)

    -> returns function(req, res, next) {

      // which populates req.options
      req.options = req.options || {}

      // And pagination, sort & fields on req.options
      req.options.pagination = {
        offset: 0
        limit: 50
      }
      req.options.sort = {
        title: 'asc'
      }

      req.options.fields = ['title', 'name']
    }

### sort
### fields
### pagination
