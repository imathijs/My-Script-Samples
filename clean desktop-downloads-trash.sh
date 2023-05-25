#!/bin/bash
#
# CLEAN DESKTOP, DOWNLOADS & TRASH
# CAN BE USED AT FOR LOGIN

currentUser=$( echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }' )

runAsUser() {  
	if [[ "${currentUser}" != "loginwindow" ]]; then
		launchctl asuser "$uid" sudo -u "${currentUser}" "$@"
	else
		echo "no user logged in"
		exit 1
	fi
}

if [ $currentUser == "flex" ]  || [ $currentUser == "flex2" ] ; then

echo "Do cleanup for user $currentUser..."
runAsUser /bin/rm -frv /Users/$currentUser/Desktop/*
runAsUser /bin/rm -frv /Users/$currentUser/Downloads/*
runAsUser /bin/rm -frv /Users/$currentUser/.Trash/*
echo "Clean up done..."

	else
		echo "Account is not a Flex account. Do nothing."
	fi

exit 0