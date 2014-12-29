chai = require 'chai'
chaid = require '..'

chai.should()
chai.use chaid

describe 'chaid', ->
  describe '.id', ->
    it 'compares string representations of ids', ->
      {id: 'foo'}.should.have.same.id {id: 'foo'}
      {id: 'foo'}.should.not.have.same.id {id: 'bar'}

    it 'discovers ids at _id', ->
      {_id: 'foo'}.should.have.same.id {_id: 'foo'}

    it 'accepts string ids passed in directly', ->
      {id: 'foo'}.should.have.id 'foo'

    it 'accepts ObjectIds passed in directly', ->
      {id: 'foo'}.should.have.id {toHexString: -> 'foo'}

    it 'stringifies object representations of ids', ->
      {id: {toString: -> 'foo'}}.should.have.same.id {_id: 'foo'}

    it 'ignores other attributes', ->
      {id: 'foo', bar: 2}.should.have.same.id {id: 'foo', baz: 3}

    it 'throws if it cant find an id', ->
      (-> {foo: 'bar'}.should.have.id 'baz').should.throw(/could not get an id/)

    it 'refuses to compare null ids', ->
      (-> {id: 'foo'}.should.have.id null).should.throw(/will not compare/)

  describe '.ids', ->
    it 'asserts that target has only the matching ids in the same order', ->
      [{id:'a'}, {id:'b'}].should.have.ids ['a', 'b']
      [{id:'a'}, {id:'b'}].should.have.same.ids [{id:'a'}, {id:'b'}]
      [{id:'a'}, {id:'b'}].should.not.have.same.ids [{id:'a'}]
      [{id:'a'}, {id:'b'}].should.not.have.same.ids [{id:'a'}, {id:'b'}, {id:'c'}]
      [{id:'a'}, {id:'b'}].should.not.have.same.ids [{id:'b'}, {id:'a'}]

  describe 'unordered.ids', ->
    it 'relaxes assertion to unordered ', ->
      [{id:'a'}, {id:'b'}].should.have.same.unordered.ids [{id:'b'}, {id:'a'}]
      [{id:'a'}, {id:'b'}].should.not.have.same.unordered.ids [{id:'a'}]

  describe 'include.ids', ->
    it 'relaxes assertion to matching unordered subset ', ->
      [{id:'a'}, {id:'b'}].should.include.ids ['a']
      [{id:'a'}, {id:'b'}].should.not.include.ids ['c']
      [{id:'a'}, {id:'b'}].should.include.same.ids [{id:'b'}, {id:'a'}]
      [{id:'a'}].should.not.include.same.ids [{id:'b'}, {id:'a'}]
