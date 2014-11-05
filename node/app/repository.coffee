uuid = require 'node-uuid'
appUtils = require './utils'

module.exports.getTasks = (db, condition, callback)->

  db.command 'select', {table: 'Tasks'}, (e, result)->

    r = appUtils.parseGroongaSelectResult(result)

    callback null, r.items

module.exports.postTask = (db, task, callback)->

  task._key = uuid.v4()
  task.done = task.done or false
  now = new Date().getTime()
  task.created = now
  task.updated = now

  db.command 'load', {
    table: 'Tasks',
    ifexists: 0,
    values: JSON.stringify [ task ]
  }, (e, count)->

    return callback e if e
    return callback new Error('update failed') if not count
 
    callback null, task

module.exports.putTask = (db, task, callback)->

  db.command 'select', {
    table: 'Tasks',
    _key: task._key
  }, (e, result)->
    
    r = appUtils.parseGroongaSelectResult(result)

    return callback e if e
    return callback new Error('not found task') if not r.count

    task.updated = new Date().getTime()
 
    db.command 'load', {
      table: 'Tasks',
      values: JSON.stringify [ task ]
    }, (e, count)->
    
      return callback e if e
      return callback new Error('update failed') if not count
    
      callback null, task

module.exports.deleteTask = (db, key, callback)->

  db.command 'delete', {
    table: 'Tasks',
    key: key
  }, (e, success)->
 
    return callback e if e
    return callback new Error('delete failed') if not success

    do callback
