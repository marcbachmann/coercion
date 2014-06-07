dateRange = require('../../').dateRange

describe 'dateRange()', ->

  it 'returns always an object', ->
    expect(dateRange()).to.be.an('object')
    expect(dateRange('foo')).to.be.an('object')
    expect(dateRange(123)).to.be.an('object')
    expect(dateRange(null)).to.be.an('object')
    expect(dateRange([])).to.be.an('object')
    expect(dateRange({})).to.be.an('object')

  describe 'parses from date when', ->
    it 'called with a number', ->
      date = dateRange(1234567890100)
      expect(date.from.getTime()).to.be.equal(1234567890100)

    it 'called with a negative number', ->
      date = dateRange(-1234567890100)
      expect(date.to.getTime()).to.be.equal(1234567890100)

   it 'called with a number string', ->
      date = dateRange("1234567890100")
      expect(date.from.getTime()).to.be.equal(1234567890100)

    it 'called with a negative number string', ->
      date = dateRange("-1234567890100")
      expect(date.to.getTime()).to.be.equal(1234567890100)

   it 'called with a ISO Timestamp', ->
      date = dateRange("2014-05-25T08:43:25.828Z")
      expect(date.from?.getTime()).to.be.equal(new Date('2014-05-25T08:43:25.828Z').getTime())
