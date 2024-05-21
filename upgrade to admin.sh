#!/bin/zsh
# Upgrade to admin

currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! / loginwindows/ { print $3 }' )

echo "Give admin rights for user: $currentUser"

/usr/sbin/dseditgroup -o edit -a $currentUser -t user admin

exit 0
