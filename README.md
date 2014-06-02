# api-query-parser
## Node module with query helpers to write a REST API

# Usage
    
    parse = require('api-query-parser') 

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

    parse.csv('allowed,created,title,notallowed', ['allowed', 'created', 'title'])

    [ 'allowed', 'created', 'title' ]


### integer
Always returns a number. Default value is 0

	// always returns a number
	parse.integer('foo')
	
	0

	// Use a default value
	parse.integer('foo', 10)

	10


	// Use a maxium value
	parse.integer(1000, 10, 100)

	100


### positiveInteger
Always returns a number. Default value is 0

	// parse.positiveInteger(number as string or int, default, max value)
	parse.positiveInteger(req.query.limit, 10, 100)

	100


### date
Always returns a date. Undefined if parsing failed.

    parse.dateRange("2014-01-01-2014-06-01")
    
    {
      from: Wed Jan 01 2014 01:00:00 GMT+0100 (CET),
      to: Sun Jun 01 2014 02:00:00 GMT+0200 (CEST)
    }


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
### sort
### fields
### pagination
