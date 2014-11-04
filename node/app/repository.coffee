nroonga = require('nroonga')
#db = new nroonga.Database('database')

module.exports.getTasks = (condition, callback)->

  callback null, []

module.exports.postTask = (task, callback)->

  callback null, task

module.exports.putTask = (task, callback)->

  callback null, task

module.exports.deleteTask = (key, callback)->

  do callback
