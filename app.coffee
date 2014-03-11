{exec} = require 'child_process'
	
express = (require 'express')
app = express()
server = (require 'http').createServer app
io = (require 'socket.io').listen server, log:false

pub = __dirname + '/public'

app.use app.router
app.use '/components', express.static __dirname + '/bower_components'
app.use express.static pub
app.use express.errorHandler()

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.get '/', (req,res) ->
	res.render 'main'

app.post '/refresh', (req,res) ->
	res.send 200
	process.exit 200

o = require 'observable'
users = o 0

redis = require 'node-redis'
client = undefined
if process.env.REDIS_PORT_6379_TCP_PORT? and process.env.REDIS_PORT_6379_TCP_ADDR?
	client = redis.createClient process.env.REDIS_PORT_6379_TCP_PORT, process.env.REDIS_PORT_6379_TCP_ADDR

text = o 'welcome to AWS'
io.sockets.on 'connection', (socket) ->
	byes = []
	bye = ->
		byes.map (f) -> f()

	users users() + 1
	socket.emit 'news', hello : 'world'

	mine = undefined
	byes.push text (t) ->
		if t != mine
			mine = t
			socket.emit 'text', t

	byes.push users (u) ->
		socket.emit 'news', 
			num_users : u
			redis_init : client?

	socket.on 'text', (data) ->
		mine = data
		text data

	socket.once 'disconnect', ->
		bye()
		users users() - 1

port = process.argv[2] or 80
server.listen port

console.log 'server is running!4'