express = require 'express'

app = express()
pub = __dirname + '/public'

app.use app.router
app.use '/components', express.static __dirname + '/bower_components'
app.use express.static pub
app.use express.errorHandler()

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'


app.get '/', (req,res) ->
	res.render 'main'

app.post '/refresh', ->
	process.exit 200

port = process.argv[2] or 80
app.listen port
