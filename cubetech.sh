#!/bin/bash

if [ -f ~/.ctconfig ]; then
	source ~/.ctconfig
	echo "Project: "
	echo ${PWD##*/}
	../../bin/wp package install aaemnnosttv/wp-cli-dotenv-command
	cp .env.example .env
	../../bin/wp dotenv set DB_NAME `echo $CTUSER`_`echo ${PWD##*/}`
	../../bin/wp dotenv set DB_USER `echo $CTUSER`
	../../bin/wp dotenv set DB_PASSWORD \"`echo $CTPW`\"
	../../bin/wp dotenv set DB_HOST localhost
	../../bin/wp dotenv set WP_HOME http://${PWD##*/}.$CTUSER.dev.cubetech.ch
	../../bin/wp db create --quiet
	../../bin/wp core install --url=http://${PWD##*/}.$CTUSER.dev.cubetech.ch --title=${PWD##*/} --admin_user=$CTWPUSER --admin_password=$CTWPPW --admin_email=$CTWPMAIL
else
	echo "No cubetech config available."
	exit 0
fi