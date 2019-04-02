const dateRange = require('../../').dateRange

describe('dateRange()', function () {
  it('returns always an object', function () {
    expect(dateRange()).to.be.an('object')
    expect(dateRange('foo')).to.be.an('object')
    expect(dateRange(123)).to.be.an('object')
    expect(dateRange(null)).to.be.an('object')
    expect(dateRange([])).to.be.an('object')
    expect(dateRange({})).to.be.an('object')
  })

  describe('parses from date when', function () {
    it('called with a number', function () {
      const date = dateRange(1234567890100)
      expect(date.from.getTime()).to.be.equal(1234567890100)
    })

    it('called with a negative number', function () {
      const date = dateRange(-1234567890100)
      expect(date.to.getTime()).to.be.equal(1234567890100)
    })
  })

  it('called with a number string', function () {
    const date = dateRange('1234567890100')
    expect(date.from.getTime()).to.be.equal(1234567890100)
  })

  it('called with a negative number string', function () {
    const date = dateRange('-1234567890100')
    expect(date.to.getTime()).to.be.equal(1234567890100)
  })

  it('called with a ISO Timestamp', function () {
    const date = dateRange('2014-05-25T08:43:25.828Z')
    expect(date.getTime()).to.be.equal(new Date('2014-05-25T08:43:25.828Z').getTime())
  })
})
