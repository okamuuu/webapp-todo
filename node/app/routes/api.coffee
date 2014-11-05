router = require('express').Router()
async = require 'async'
config = require 'config'

nroonga = require('nroonga')
db = new nroonga.Database(config.database)

repository = require './../repository'

router.get '/', (req, res)->
  res.json { message: 'hooray! welcome to our api!' }

router.get '/tasks', (req, res)->

  repository.getTasks db, {}, (e, tasks)->
    
    if e
      console.error e
      return res.json {status:'ng'}

    res.json tasks

router.put '/tasks/:key', (req, res)->
  
  targetKey = req.params.key

  if not targetKey
    console.error new Error('params key is required!!')
    return res.json {status:'ng'}
  
  if req.body.done is null
    console.error new Error('params done is required!!')
    return res.json {status:'ng'}

  repository.putTask db, {
    _key: targetKey,
    done: req.body.done
  }, (e, task)->

    if e
      console.error e
      return res.json {status:'ng'}
      
    res.json task

router.delete '/tasks/:key', (req, res)->

  targetKey = req.params.key
 
  if not targetKey
    console.error new Error('params key is required')
    return res.json {status:'ng'}

  repository.deleteTask db, targetKey, (e)->

    if e
      console.error e
      return res.json {status:'ng'}

    res.json {status:'ok'}

router.post '/tasks', (req, res)->
 
  if not req.body.title
    console.error new Error('params title is required')
    return res.json {status:'ng'}

  newTask =
    title: req.body.title
    done: req.body.done or false

  repository.postTask db, newTask, (e, task)->
   
    if e
      console.error e
      return res.json {status:'ng'}
    
    res.json {status:'ok'}

module.exports = router
