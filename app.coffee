{exec} = require 'child_process'
exec "coffee -c -o public/lib/ src/", (err) ->
	console.log 'coffee ready', err
	
express = (require 'express')
app = express()
server = (require 'http').createServer app
io = (require 'socket.io').listen server

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

io.sockets.on 'connection', (socket) ->
	socket.emit 'news', hello : 'world'
	socket.on 'cevent', (data) ->
		console.log data

port = process.argv[2] or 80
server.listen port
