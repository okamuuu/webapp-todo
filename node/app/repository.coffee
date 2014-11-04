config = require 'config'
nroonga = require 'nroonga'
db = new nroonga.Database config.database

module.exports.getTasks = (condition, callback)->

  db.command 'table_list', (e, result)->
    console.log(e, result)

    callback null, []

module.exports.postTask = (task, callback)->

  callback null, task

module.exports.putTask = (task, callback)->

  callback null, task

module.exports.deleteTask = (key, callback)->

  do callback
