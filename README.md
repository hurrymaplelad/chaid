chaid
==============

Id equality assertions for chai

[![NPM version](http://img.shields.io/npm/v/chaid.svg?style=flat-square)](https://www.npmjs.org/package/chaid)
[![Build Status](http://img.shields.io/travis/hurrymaplelad/chaid/master.svg?style=flat-square)](https://travis-ci.org/hurrymaplelad/chaid)

Chaid converts many different id representations to strings for comparison:
```js
{_id: 'foo'}.should.have.id('foo')
{id: 'foo', bar: 2}.should.have.same.id({id: 'foo', baz: 3})
{_id: 'foo'}.should.not.have.same.id({_id: 'bar'})
{_id: 'foo'}.should.have.same.id({id: {toString: function() { return 'foo'}})
{_id: 'foo'}.should.have.id(new ObjectId('foo'))
```

Works well with [MongoDB ObjectIds](https://github.com/mongodb/node-mongodb-native).
#### Installation

This is a plugin for the [Chai Assertion Library](http://chaijs.com). Install via [npm](http://npmjs.org).

    npm install chaid


#### Plugin

Use this plugin as you would all other Chai plugins.

```js
var chai = require('chai')
  , chaid = require('chaid');

chai.use(chaid);
```
