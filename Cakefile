{exec} = require 'child_process'
task 'sbuild', ->
	console.log 'git!'
	exec "coffee -c -o public/lib/ src/", (err) ->
		console.log 'coffee', err
		exec "git add . --all && git commit -m 'bump' && git push", (err) ->
			console.log err