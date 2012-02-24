vows = require 'vows'
should = require 'should'
Tags = require '../../collections/tags'

vows.describe('Tags (collections/tags)').addBatch(
  'when find() is called with criteria and a callback': {
    topic: () -> getTags('test1').find({ 'one': true }, @callback)

    'it should call find() in \'tags\' collection on base': (err, items) ->
      callsToFind.test1.should.have.length(1)
      callsToFind.test1[0].should.have.length(3)
      callsToFind.test1[0][0].should.equal('tags')

    'it should call find() with criteria on base': (err, items) ->
      callsToFind.test1[0][1].should.eql({ 'one': true })
  }
).export(module)

callsToFind = {}

getTags = (key) ->
  callsToFind[key] = []
  tags = new Tags()
  tags._adapter =
    find: (collection, criteria, callback) ->
      callsToFind[key].push([collection, criteria, callback])
      callback(null, [])
  return tags