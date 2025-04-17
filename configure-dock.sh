#!/bin/bash

# SCRIPT USES DOCKUTILv3
# https://github.com/kcrawford/dockutil
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# VARIABLES
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

macosBuild=$(sw_vers -buildVersion)
macosProduct=$(sw_vers -productVersion)
macosShortVers=$(echo "$macosBuild" | head -c2)
dockutil=$(which dockutil)
sleepTime=5
recentapps=yes

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# FUNCTIONS
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function launchpad() {
	# IF MACOS 10.15 OR HIGHER
	if [ "$macosShortVers" -ge 19 ] ; then
		path="/System/Applications"
	else
		# ADD LAUNCHPAD ON LEGACY OS
		path="/Applications"
	fi
	launchpath="${path}/Launchpad.app"
}
launchpad

function appstore() {
	# IF MACOS 10.15 OR HIGHER
	if [ "$macosShortVers" -ge 19 ] ; then
		path="/System/Applications"
	else
		# ADD LAUNCHPAD ON LEGACY OS
		path="/Applications"
	fi
	appstorepath="${path}/App Store.app"
}
appstore

function system_settings() {
	if [ "$macosShortVers" -ge 22 ]; then
		# IF MACOS 13 OR HIHGER
		path="/System/Applications/System Settings.app"
	else
		# IF MACOS 12 OR LOWER
		path="/System/Applications/System Preferences.app"
	fi
	systempath=${path}
}
system_settings

function safari() {
	if [ "$macosShortVers" -ge 22 ]; then
		# IF MACOS 13 OR HIHGER
		path="/System/Cryptexes/App/System/Applications"
	else
		# IF MACOS 12 OR LOWER
		path="/Applications"
	fi
	safaripath="${path}/Safari.app"
}
safari

function dockutil_default() {
	# ADD APP(S) IN DOCK
	for app in "${user_apps[@]}"; do
		$dockutil --add "${app}" --no-restart --allhomes
	done
	
	# ADD FOLDER(S) IN DOCK
	for folder in "${user_folders[@]}"; do
		$dockutil --add "~/${folder}" --no-restart --allhomes
	done
}

function dockutil_clean() {
	echo "Removing all current dock items"
	$dockutil --remove all --no-restart --allhomes
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# APP LIST
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

user_apps=(
	"$launchpath"  ### LAUNCHPAD
	# "$appstorepath" ### APPSTORE
	"/Applications/Privileges.app"
	"$safaripath" ### SAFARI
	"/Applications/Google Chrome.app"
	"/Applications/Microsoft Outlook.app"
	"/Applications/Microsoft Word.app"
	"/Applications/Microsoft Excel.app"
	"/Applications/Microsoft PowerPoint.app"
	"/Applications/Microsoft Teams.app"
	"/Applications/Visual Studio Code.app"
	"$systempath" ### SYSTEM SETTINGS
	"/Applications/Self Service.app"
)

user_folders=(
	"Downloads"  ### DOWNLOADS FOLDER
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Start script
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
dockutil_clean
dockutil_default

echo "Turning off recents"

#Who is the current user?
currentuser=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ && ! / loginwindows/ { print $3 }')

#Change Dock setting to not show recent apps
/usr/bin/defaults write "/Users/$currentuser/Library/Preferences/com.apple.dock.plist" show-recents -bool false

#Change ownership of the Dock plist file to the current user.
chown $currentuser "/Users/$currentuser/Library/Preferences/com.apple.dock.plist"

/usr/bin/defaults write com.apple.dock show-recents -bool FALSE


# Cleanup
sleep $sleepTime

echo "Restarting Dock"
/usr/bin/killall Dock >/dev/null 2>&1