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

o = require 'observable'
users = o 0

io.sockets.on 'connection', (socket) ->
	byes = []
	bye = ->
		byes.map (f) -> f()

	users users() + 1
	socket.emit 'news', hello : 'world'

	byes.push users (u) ->
		socket.emit 'news', num_users : u

	socket.on 'cevent', (data) ->
		console.log data
	socket.once 'disconnect', ->
		bye()
		users users() - 1

port = process.argv[2] or 80
server.listen port
