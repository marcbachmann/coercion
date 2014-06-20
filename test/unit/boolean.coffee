boolean = require('../../').boolean

describe 'boolean()', ->

  it 'returns a boolean', ->
    values = [null, undefined, 123, 'foo', ['foo'], {}, {foo: 'bar'}]
    for value in values
      expect(boolean(value)).to.be.an('boolean')

  describe 'returns true', ->
    it 'for Boolean(true)', ->
      expect(boolean(true)).to.be.equal(true)

    it 'for String(true)', ->
      expect(boolean(String(true))).to.be.equal(true)

    it 'for Number(1)', ->
      expect(boolean(Number('1'))).to.be.equal(true)

    it 'for String(yes)', ->
      expect(boolean(String('yes'))).to.be.equal(true)


  describe 'returns false', ->
    it 'for everything else', ->
      values = [false, 'false', '0', 'no', null, undefined, 123, 'foo', ['foo'], {}, {foo: 'bar'}]
      for value in values
        expect(boolean(value)).to.be.equal(false)
