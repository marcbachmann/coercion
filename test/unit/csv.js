const csv = require('../../').csv

describe('csv()', function () {

  it('returns an array', function () {
    const values = [null, undefined, 123, 'foo', ['foo'], {}, {foo: 'bar'}]
    for (const value of values) {
      expect(csv(value)).to.be.an('array')
    }
  })

  it('only works with strings and numbers', function () {
    for (const value of [null, undefined, ['foo'], {}, {foo: 'bar'}]) {
      expect(csv(value).length).to.be.equal(0)
      expect(csv(value)[0]).to.be.undefined
    }

    for (const value of ['foo', 123]) {
      expect(csv(value)[0]).to.be.equal(String(value))
    }
  })

  it('returns array of strings', function () {
    for (const value of ['foo', 'foo,bar', 123]) {
      for (const result of csv(value)) {
        expect(result).to.be.a('string')
      }
    }
  })

  it('returns only allowed strings', function () {
    const result = csv('foo,foo.bar,notAllowed', {allowed: ['foo', 'foo.bar']})
    expect(result).to.contain('foo')
    expect(result).not.to.contain('notAllowed')
  })

  it('returns default value when result would be empty', function () {
    const res1 = csv('notAllowed', {default: 'foo', allowed: ['foo', 'foo.bar']})
    expect(res1).to.be.equal('foo')

    const res2 = csv('notAllowed', {default: ['foo'], allowed: ['foo', 'foo.bar']})
    expect(res2[0]).to.be.equal('foo')
  })

  it('Accepts wildcards in allowed array', function () {
    const result = csv('foo.bar', {allowed: ['foo', 'foo.*']})
    expect(result).to.deep.equal(['foo.bar'])
  })

  it('Accepts multiple wildcards in allowed array', function () {
    const result = csv('foo.bar,bla.test,bla.*,bla', {allowed: ['foo', 'foo.*', 'bla.*']})
    expect(result).to.deep.equal(['foo.bar', 'bla.test', 'bla.*'])
  })
})
