echo hello loop
while true
do
	coffee app.coffee
	if [ $? -eq 0 ]
	then
		break
	fi
	echo refresh
    git pull
    npm i
    bower i
done
