router = require('express').Router()
async = require 'async'
uuid = require 'uuid'

nroonga = require('nroonga')
db = new nroonga.Database('database')

redis = require 'redis'
redisClient = redis.createClient()

redisClient.on "error", (e)-> console.error e

router.get '/', (req, res)->
  res.json { message: 'hooray! welcome to our api!' }

router.get '/tasks', (req, res)->

  tasks = []
  redisClient.keys "tasks:*", (e, keys)->

    async.eachSeries keys, (key, next)->
    
      redisClient.hgetall key, (e, res)->
        next e if e
        res.done = if res.done is 'true' then true else false
        tasks.push(res)
        do next

    , (e)->
      console.log e if e
      
      res.json tasks

router.put '/tasks/:id', (req, res)->
  
  targetId = req.params.id

  return res.json {status:'ng'} if not targetId
  return res.json {status:'ng'} if req.body.done is null

  redisClient.hgetall targetId, (e, task)->

    return res.json {status:'ng'} if e
    return res.json {status:'ng'} if not task
      
    redisClient.hset targetId, "done", req.body.done, (e, reply)->

      return res.json {status:'ng'} if e

      task.done = req.body.done
      res.json task

router.delete '/tasks/:id', (req, res)->
  
  targetId = req.params.id
  
  return res.json {status:'ng'} if not targetId

  redisClient.del targetId, (e, reply)->
    return res.json {status:'ng'} if e
    res.json {status:'ok'}

router.post '/tasks', (req, res)->

  id = "tasks:" + uuid.v4()

  redisClient.hmset id,
    id: id
    title: req.body.title
    done: req.body.done or false
    created: (new Date).getTime()
  , (e, reply)->
    return res.json {status:'ng'} if e
    res.json {status:'ok'}

module.exports = router
