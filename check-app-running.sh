#!/bin/bash

PROCESS=$( pgrep "Dropbox" )
DROPBOX="/Applications/Dropbox.app"


if [[ -z "$PROCESS" ]]; then
	
	echo "Dropbox not running..."
	
	if [ -e "$DROPBOX" ]; then
		
		echo "Start"
		open "$DROPBOX"
		exit 0
		
	else
		
		echo "Dropbox is not installed"
	    exit 1
		
	fi
	
else 
	
	echo "Dropbox is running, do nothing."
	exit 0
	
fi