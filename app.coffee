express = require 'express'
app = express()
app.post '/refresh', ->
	process.exit 200
app.get '/', (req,res) ->
	console.log 'hello aws'
	res.send 'ok'
app.listen 80
