pagination = require('../../').pagination

describe 'pagination()', ->

  it 'returns an object', ->
    values = [null, undefined, 123, 'foo', {}, []]
    for value in values
      expect(pagination(value)).to.be.an('object')

  it 'always returns offset and limit', ->
    values = [null, undefined, 123, 'foo', {}, [], {page: 2}]
    for value in values
      expect(pagination(value).offset).to.be.a('number')
      expect(pagination(value).limit).to.be.a('number')

  it 'has a default limit of 50', ->
    expect(pagination().limit).to.be.equal(50)

  it 'allows to override the default limit', ->
    expect(pagination(default: 2).limit).to.be.equal(2)

  it 'allows to set the maximum limit', ->
    expect(pagination(limit: 50, max: 2).limit).to.be.equal(2)

  it 'allows a page and limit argument', ->
    page = pagination(limit: 50, page: 5)
    expect(page.limit).to.be.equal(50)
    expect(page.offset).to.be.equal(200)

  it 'allows an offset and limit argument', ->
    page = pagination(limit: 50, offset: 40)
    expect(page.limit).to.be.equal(50)
    expect(page.offset).to.be.equal(40)

  it 'allows all options together', ->
    page = pagination(page: 4, limit: 50, offset: 40, max: 20, default: 10)
    expect(page.limit).to.be.equal(20)
    expect(page.offset).to.be.equal(60)
