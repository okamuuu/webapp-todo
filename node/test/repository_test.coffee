process.env.NODE_ENV = 'test'

require 'coffee-script'
require 'coffee-errors'

assert = require 'assert'

repository = require '../app/repository'

describe 'repository', ->

  describe 'get tasks', ()->
    
    it 'should return tasks', (done)->

      repository.getTasks {}, (e, tasks)->
        assert.ok(!e)
        assert.ok(tasks.length is 0)
        do done

  describe 'post task', ()->
    
    it 'should return new task', (done)->

      repository.postTask {title:'test1'}, (e, task)->
        assert.ok(!e)
        assert.ok(task.title is 'test1')
        do done

  describe 'put task', ()->
    
    it 'should return modified task', (done)->

      repository.putTask {title:'test2'}, (e, task)->
        assert.ok(!e)
        assert.ok(task.title is 'test2')
        do done

  describe 'delete task', ()->
    
    it 'should return null', (done)->

      repository.deleteTask 'key', (e)->
        assert.ok(!e)
        do done

