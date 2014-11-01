process.env.NODE_ENV = 'test'

request = require 'supertest'
app = require '../app'

describe '/api', ->

  describe 'GET', ()->
    
    it 'should return 200 with json', (done)->
  
      request(app)
        .get('/api')
        .expect('Content-Type', /json/)
        .expect(200, { message: 'hooray! welcome to our api!' })
        .end (err, res)->
          throw err if err
          console.log(res.body)
          do done
