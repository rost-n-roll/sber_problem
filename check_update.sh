#!/bin/bash

ISRUNNING=1

# 1. Check for updates
UPDATES=$(/usr/sbin/softwareupdate --list | grep "Software Update found")

if [[ -z "$UPDATES" ]]; then
	# No updates available
	exit 0

else
	# 2. Updates available
	while [[ $ISRUNNING = 1 ]]; do
		USER_CHOICE=$(osascript <<EOF
		display dialog "Доступны обновления системы" buttons {"Обновиться сейчас", "Отложить на 1 час"} default button "Обновиться сейчас"
		return button returned of result
		EOF)

		# 3. Update or one hour delay
		if [[ $USER_CHOICE = "Обновиться сейчас" ]]; then
			ISRUNNING=0
			/usr/sbin/softwareupdate --install --all --restart
		
		#Sleep for one hour 
		elif [[ $USER_CHOICE = "Отложить на 1 час" ]]; then
			sleep 3600
		fi
	done
fi