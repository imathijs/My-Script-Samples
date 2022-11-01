#!/bin/zsh

# DEBUG MODE (0 = FALSE / 1 = TRUE)
DEBUG=1

URL=<url>

# CURRENT LOGGEDIN USER
currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! / loginwindows/ { print $3 }' )
firstLetter=$( echo $currentUser | head -c 1)


if [ $DEBUG = 0 ] ; then
	
	echo "mount volume smb://${URL}/Homes/${firstLetter}/${currentUser}/"

else
	
	/usr/bin/osascript > /dev/null << EOT

		tell application "Finder" 
		activate
		mount volume "smb://${URL}/Homes/${firstLetter}/${currentUser}/"
		end tell

EOT
	
fi
