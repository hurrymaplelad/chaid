chai = require 'chai'
chaid = require '..'

chai.should()
chai.use chaid

describe 'chaid', ->
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
