#!/bin/bash

# SCRIPT USES DOCKUTILv3
# https://github.com/kcrawford/dockutil

#Folders to add to the dock
user_folders=("Downloads")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Variables
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
macosBuild=$(sw_vers -buildVersion)
macosProduct=$(sw_vers -productVersion)
macosShortVers=$(echo "$macosBuild" | head -c2)
dockutil=$(which dockutil)
sleepTime=5

echo "Removing all current dock items"
$dockutil --remove all --no-restart --allhomes

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Functions for different macOS builds
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

function launchpad_appstore() {
	# IF CATALINA OR HIGHER
	if [ "$macosShortVers" -ge 19 ] ; then
		# ADD LAUNCHPAD ON CATALINE OR HIGHER
		echo "macOS version: $macosProduct, will use path /System/Applications/"
		$dockutil --add "/System/Applications/Launchpad.app" --no-restart --allhomes
		$dockutil --add "/System/Applications/App Store.app" --no-restart --allhomes
	else
		# ADD LAUNCHPAD ON LEGACY OS
		echo "macOS version: $macosProduct, will path /Applications/"
		$dockutil --add "/Applications/Launchpad.app" --no-restart --allhomes
		$dockutil --add "/Applications/App Store.app" --no-restart --allhomes	
	fi
}

function system_setting() {
	# SYSTEM SETTINGS / SYSTEM PREFERENCES
	if [ "$macosShortVers" -ge 22 ]; then
		# ADD SYSTEM SETTINGS ON VENTURA OR HIHGER
		echo "macOS version: $macosProduct, will use System Settings.app"
		$dockutil --add "/System/Applications/System Settings.app" --no-restart --allhomes
	else
		# ADD SYSTEM PREFERENCES ON MONTEREY AND LOWER
		echo "macOS version: $macosProduct, will use System Preferences.app"
		$dockutil --add "/System/Applications/System Preferences.app" --no-restart --allhomes
	fi
}

function dockutil_default() {
	
	launchpad_appstore
	$dockutil --add "/Applications/Self Service.app" --no-restart --allhomes
	$dockutil --add "/Applications/Safari.app" --no-restart --allhomes
	$dockutil --add "/Applications/Google Chrome.app" --no-restart --allhomes
	$dockutil --add "/Applications/Microsoft Excel.app" --no-restart --allhomes
	$dockutil --add "/Applications/Microsoft OneNote.app" --no-restart --allhomes
	$dockutil --add "/Applications/Microsoft Outlook.app" --no-restart --allhomes
	$dockutil --add "/Applications/Microsoft PowerPoint.app" --no-restart --allhomes
	$dockutil --add "/Applications/Microsoft Word.app" --no-restart --allhomes
	$dockutil --add "/Applications/Microsoft Teams.app" --no-restart --allhomes
	system_setting
	$dockutil --add "/Applications/TeamViewerQS.app" --no-restart --allhomes
	
	for folder in "${user_folders[@]}"; do
		$dockutil --add "~/${folder}" --no-restart --allhomes
	done
}


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Start script
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


dockutil_default

echo "Turning off recents"
defaults write com.apple.dock show-recents -bool FALSE

# Cleanup
sleep $sleepTime

echo "Restarting Dock"
/usr/bin/killall Dock >/dev/null 2>&1

exit 0