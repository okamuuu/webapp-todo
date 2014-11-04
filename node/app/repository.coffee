module.exports.getTasks = (db, condition, callback)->

  db.command 'select', {table: 'Tasks'}, (e, result)->
    #console.log(e, result)

    callback null, []

module.exports.postTask = (db, task, callback)->

  callback null, task

module.exports.putTask = (db, task, callback)->

  callback null, task

module.exports.deleteTask = (db, key, callback)->

  do callback
