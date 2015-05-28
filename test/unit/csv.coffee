csv = require('../../').csv

describe 'csv()', ->

  it 'returns an array', ->
    values = [null, undefined, 123, 'foo', ['foo'], {}, {foo: 'bar'}]
    for value in values
      expect(csv(value)).to.be.an('array')


  it 'only works with strings and numbers', ->
    for value in [null, undefined, ['foo'], {}, {foo: 'bar'}]
      expect(csv(value).length).to.be.equal(0)
      expect(csv(value)[0]).to.be.undefined

    for value in ['foo', 123]
      expect(csv(value)[0]).to.be.equal(String(value))


  it 'returns array of strings', ->
    for value in ['foo', 'foo,bar', 123]
      for result in csv(value)
        expect(result).to.be.a('string')


  it 'returns only allowed strings', ->
    result = csv('foo,foo.bar,notAllowed', allowed: ['foo', 'foo.bar'])
    expect(result).to.contain('foo')
    expect(result).not.to.contain('notAllowed')


  it 'returns default value when result would be empty', ->
    result = csv('notAllowed', default: 'foo', allowed: ['foo', 'foo.bar'])
    expect(result).to.be.equal('foo')

    result = csv('notAllowed', default: ['foo'], allowed: ['foo', 'foo.bar'])
    expect(result[0]).to.be.equal('foo')


  it 'Accepts wildcards in allowed array', ->
    result = csv('foo.bar', allowed: ['foo', 'foo.*'])
    expect(result).to.deep.equal(['foo.bar'])


  it 'Accepts multiple wildcards in allowed array', ->
    result = csv('foo.bar,bla.test,bla.*,bla', allowed: ['foo', 'foo.*', 'bla.*'])
    expect(result).to.deep.equal(['foo.bar', 'bla.test', 'bla.*'])
