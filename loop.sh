echo hello loop
while true
do
    npm i
    bower i --allow-root
    browserify -c 'coffee -sc' src/main.coffee -o public/lib/main.js
	coffee app.coffee $1
	if [ $? -eq 0 ]
	then
		break
	fi
	echo refresh
    git pull
done
