require 'coffee-script'
require 'coffee-errors'

express    = require 'express'
bodyParser = require 'body-parser'

module.exports = app = express()

app.use bodyParser.urlencoded {extended:true}
app.use bodyParser.json()

port = process.env.PORT or 8080

apiRouter = require __dirname + '/app/routes/api'

app.use '/api', apiRouter
app.use '/', express.static(__dirname + '/public')

if not module.parent
  app.listen port
  console.log 'Magic happens on port ' + port
