router = require('express').Router()

tasks = [
    {id: 1, title: 'title1', desc: 'desc1', done: true},
    {id: 2, title: 'title2', desc: 'desc2', done: false},
  ]

lastIndex = 2

router.get '/', (req, res)->
  res.json { message: 'hooray! welcome to our api!' }

router.get '/tasks', (req, res)->
  res.json tasks

router.get '/tasks/:id', (req, res)->

  targetId = parseInt req.params.id, 10

  for task in tasks
    if task.id is targetId
      return res.json task

  res.json task

router.put '/tasks/:id', (req, res)->
  
  targetId = parseInt req.params.id, 10
  
  targetTask
  for task in tasks
    if task.id is targetId
      targetTask = task

  return res.json {status:'ng'} if not targetTask

  task.title = req.body.title if req.body.title isnt null
  task.done = req.body.done if req.body.done isnt null
  
  res.json task

router.delete '/tasks/:id', (req, res)->
  
  targetId = parseInt req.params.id, 10
  
  targetIndex = 0
  for task in tasks
    if task.id is targetId
      break
    targetIndex += 1

  return res.json {status:'ng'} if not targetIndex

  tasks.splice targetIndex, 1
  res.json {status:'ok'}

router.post '/tasks', (req, res)->

  lastIndex += 1
  tasks.push {
    id: lastIndex
    title: req.body.title
    done: req.body.done or false
  }
  res.json {status:'ok'}

module.exports = router
