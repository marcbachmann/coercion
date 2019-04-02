const integer = require('../../').integer

describe('integer()', () => {

  it('returns a number', () => {
    const values = [null, undefined, 123, 'foo', {}, []]
    for (const value of values) {
      expect(integer(value), "integer('#{value}')").to.be.a('number')
    }
  })

  it('allows a default value', () => {
    const defaults = [100, -100, [], () => {}]
    for (const defaultValue of defaults) {
      expect(integer(undefined, {default: defaultValue})).to.be.equal(defaultValue)
    }
  })

  it('allows a minimum number', () => {
    expect(integer(5, {min: 10})).to.be.equal(10)
  })

  it('allows a maximum number', () => {
    expect(integer(1000, {max: 100})).to.be.equal(100)
  })

  it('allows all options simultaneous', () => {
    expect(integer(5, {max: 100, min: 10, default: 20})).to.be.equal(10)
    expect(integer(110, {max: 100, min: 10, default: 20})).to.be.equal(100)
    expect(integer('foo', {max: 100, min: 10, default: 20})).to.be.equal(20)
  })
})
