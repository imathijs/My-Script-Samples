#!/bin/zsh

currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! / loginwindows/ { print $3 }' )

echo "$currentUser"


