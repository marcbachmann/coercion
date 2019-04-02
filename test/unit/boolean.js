const boolean = require('../../').boolean

describe('boolean()', function () {

  it('returns a boolean', function () {
    const values = [null, undefined, 123, 'foo', ['foo'], {}, {foo: 'bar'}]
    for (const value of values) {
      expect(boolean(value)).to.be.an('boolean')
    }
  })

  describe('returns true', function () {
    it('for Boolean(true)', function () {
      expect(boolean(true)).to.be.equal(true)
    })

    it('for String(true)', function () {
      expect(boolean(String(true))).to.be.equal(true)
    })

    it('for Number(1)', function () {
      expect(boolean(Number('1'))).to.be.equal(true)
    })

    it('for String(yes)', function () {
      expect(boolean(String('yes'))).to.be.equal(true)
    })
  })

  describe('returns false', function () {
    it('for everything else', function () {
      const values = [
        false, 'false', '0', 'no',
        null, undefined, 123, 'foo',
        ['foo'], {}, {foo: 'bar'}
      ]

      for (const value of values) {
        expect(boolean(value)).to.be.equal(false)
      }
    })
  })
})
