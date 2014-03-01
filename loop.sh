echo hello loop
while true
do
    npm i
    bower i --allow-root
	coffee app.coffee
	if [ $? -eq 0 ]
	then
		break
	fi
	echo refresh
    git pull
done
