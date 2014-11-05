process.env.NODE_ENV = 'test'

require 'coffee-script'
require 'coffee-errors'
assert = require 'assert'

tempdir = require('temp').mkdirSync()
nroonga = require 'nroonga'
db = new nroonga.Database(tempdir + '/database')

createTempDatabase = (callback)->
  require('fs').readFile 'groonga/schema.grn', 'utf8', (e, text) ->
    text.split('\n').forEach (line)->
      db.commandSync(line) if line
    do callback

repository = require '../app/repository'

tasks = []

describe 'repository', ->

  before (done)->
    createTempDatabase done

  describe 'get tasks', ()->
    
    it 'should return tasks', (done)->

      repository.getTasks db, {}, (e, tasks)->
        assert.ok(!e)
        assert.ok(tasks.length is 0)
        do done

  describe 'post task', ()->
    
    it 'should return new task', (done)->

      repository.postTask db, {title:'test1'}, (e, task)->
        assert.ok(!e)
        assert.ok(task.title is 'test1')
        tasks.push task
        do done

  describe 'put task', ()->
    
    it 'should return modified task', (done)->

      task = tasks[0]
      task.title = 'test2'

      repository.putTask db, task, (e, task)->
        assert.ok(!e)
        assert.ok(task.title is 'test2')
        do done

  describe 'delete task', ()->
    
    it 'should return null', (done)->

      repository.deleteTask db, tasks[0]._key, (e)->
        assert.ok(!e)
        do done

