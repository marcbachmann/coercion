integer = require('../../').integer

describe 'integer()', ->

  it 'returns a number', ->
    values = [null, undefined, 123, 'foo', {}, []]
    for value in values
      expect(integer(value), "integer('#{value}')").to.be.a('number')

  it 'allows a default value', ->
    defaults = [100, -100, [], ->]
    for defaultValue in defaults
      expect(integer(undefined, default: defaultValue)).to.be.equal(defaultValue)

  it 'allows a minimum number', ->
    values = [null, undefined]
    for value in values
      expect(integer(5, min: 10)).to.be.equal(10)

  it 'allows a maximum number', ->
    values = [null, undefined]
    for value in values
      expect(integer(1000, max: 100)).to.be.equal(100)

  it 'allows all options simultaneous', ->
    expect(integer(5, max: 100, min: 10, default: 20)).to.be.equal(10)
    expect(integer(110, max: 100, min: 10, default: 20)).to.be.equal(100)
    expect(integer('foo', max: 100, min: 10, default: 20)).to.be.equal(20)
