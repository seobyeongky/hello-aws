{exec} = require 'child_process'
task 'sbuild', ->
	exec "git add . --all && git commit -m 'bump' && git push", (err) ->
		console.log err