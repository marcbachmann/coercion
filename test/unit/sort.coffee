sort = require('../../').sort

describe 'sort()', ->
  describe 'returns an object when', ->

    it 'called without parameter', ->
      expect(sort()).to.be.an('object')

    it 'called with empty string', ->
      expect(sort('')).to.be.an('object')

    it 'called with string', ->
      expect(sort('test')).to.be.an('object')

    it 'called with parameter "null"', ->
      expect(sort(null)).to.be.an('object')

    it 'called with parameter "undefined"', ->
      expect(sort(undefined)).to.be.an('object')

    it 'called with number as parameter', ->
      expect(sort(123)).to.be.an('object')

    it 'called with default sort option', ->
      expect(sort(null, '-created_at')).to.be.an('object')


  describe 'returns properties when', ->

    it 'key is a string', ->
      expect(sort('test').test).to.exist

    it 'keys are seperated using commas', ->
      keys = sort('test,key2,key3')
      expect(keys.test).to.exist
      expect(keys.key2).to.exist
      expect(keys.key3).to.exist

    it 'string contains spaces', ->
      keys = sort('test,  key3')
      expect(keys.test).to.exist
      expect(keys.key3).to.exist

    it 'key contains strange caracters', ->
      keys = sort('$?!-:.,  key3')
      expect(keys['$?!-:.']).to.exist
      expect(keys.key3).to.exist


  describe 'ignores string when', ->

    it 'not called with a string', ->
      expect(Object.keys(sort(123)).length).to.be.equal(0)
      expect(Object.keys(sort([])).length).to.be.equal(0)
      expect(Object.keys(sort({})).length).to.be.equal(0)

    it 'called with empty string', ->
      expect(Object.keys(sort('')).length).to.be.equal(0)


  describe 'sets a default property when', ->

    it 'called with invalid string', ->
      expect(Object.keys(sort(null, default: 'created_at')).length).to.be.equal(1)
      expect(Object.keys(sort([], default: 'created_at')).length).to.be.equal(1)
      expect(Object.keys(sort({}, default: 'created_at')).length).to.be.equal(1)


  describe 'returns correct values when', ->

    it 'called with ascending string', ->
      expect(sort('created_at').created_at).to.be.equal('asc')

    it 'called with descending string', ->
      expect(sort('-created_at').created_at).to.be.equal('desc')

    it 'called with ascending default option', ->
      expect(sort(null, default:'created_at').created_at).to.be.equal('asc')

    it 'called with descending default option', ->
      expect(sort(null, default: '-created_at').created_at).to.be.equal('desc')

    it 'called with multiple sort options', ->
      keys = sort('-created_at,firstname,-lastname')
      expect(keys.created_at).to.be.equal('desc')
      expect(keys.firstname).to.be.equal('asc')
      expect(keys.lastname).to.be.equal('desc')

    it 'called with multiple default sort options', ->
      keys = sort(null, default: '-created_at,firstname,-lastname')
      expect(keys.created_at).to.be.equal('desc')
      expect(keys.firstname).to.be.equal('asc')
      expect(keys.lastname).to.be.equal('desc')

    it 'called with empty string', ->
      keys = sort('', default: 'created_at,-firstname,foo')
      expect(keys.created_at).to.be.equal('asc')
      expect(keys.firstname).to.be.equal('desc')
      expect(keys.foo).to.be.equal('asc')

    it 'default options differs from string', ->
      keys = sort('-created_at,firstname,-lastname', default: 'created_at,firstname,foo')
      expect(keys.created_at).to.be.equal('desc')
      expect(keys.firstname).to.be.equal('asc')
      expect(keys.lastname).to.be.equal('desc')
      expect(keys.foo).to.be.undefined


  describe 'can restrict keys', ->

    it 'but allowes everything by default', ->
      expect(sort('created_at').created_at).to.be.equal('asc')

    it 'by using an array', ->
      expect(sort('created_at', {allowed: ['id']}).created_at).to.equal(undefined)
      expect(sort('id', allowed: ['id']).id).to.be.equal('asc')

    it 'but allows a subproperty by using an asterisk', ->
      allowed = ['afield', 'first.*', 'anotherfield']
      expect(sort('first.second', allowed: allowed)['first.second']).to.be.equal('asc')
      expect(sort('first.second.third', allowed: allowed)['first.second.third']).to.be.equal('asc')
