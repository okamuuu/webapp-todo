uuid = require 'node-uuid'

module.exports.getTasks = (db, condition, callback)->

  db.command 'select', {table: 'Tasks'}, (e, result)->

    callback null, []

module.exports.postTask = (db, task, callback)->

  task._key = uuid.v4()
  now = new Date().getTime()
  task.created = now
  task.updated = now

  db.command 'load', {
    table: 'Tasks',
    ifexists: 0,
    values: JSON.stringify [ task ]
  }, (e)->
  
    callback e, task

module.exports.putTask = (db, task, callback)->

  db.command 'select', {
    table: 'Tasks',
    _key: task._key
  }, (e, result)->

    return callback e if e
    return callback new Error('not found task') if not result[0][0][0]

    task.updated = new Date().getTime()
 
    db.command 'load', {
      table: 'Tasks',
      values: JSON.stringify [ task ]
    }, (e)->
    
      callback e, task

module.exports.deleteTask = (db, key, callback)->

  db.command 'delete', {
    table: 'Tasks',
    key: key
  }, (e, success)->
 
    return callback e if e
    return callback new Error('not found task') if not success

    do callback
