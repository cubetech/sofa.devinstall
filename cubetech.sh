#!/bin/bash

if [ -f ~/.ctconfig ]; then
	source ~/.ctconfig
	vendor/bin/wp package install aaemnnosttv/wp-cli-dotenv-command
	cp .env.example .env
	vendor/bin/wp dotenv set DB_NAME `echo $CTUSER`_`echo ${PWD##*/}`
	vendor/bin/wp dotenv set DB_USER `echo $CTUSER`
	vendor/bin/wp dotenv set DB_PASSWORD \"`echo $CTPW`\"
	vendor/bin/wp dotenv set DB_HOST localhost
	vendor/bin/wp dotenv set WP_HOME http://${PWD##*/}.$CTUSER.dev.cubetech.ch
	vendor/bin/wp db create --quiet
	vendor/bin/wp core install --url=http://${PWD##*/}.$CTUSER.dev.cubetech.ch --title=${PWD##*/} --admin_user=$CTWPUSER --admin_password=$CTWPPW --admin_email=$CTWPMAIL
else
	echo "No cubetech config available."
	exit 0
fi