#!/bin/zsh --no-rcs
#####################################################################
#
# 	Script Name		- Create-LaunchDeamon-Shutdown-Calendar-Interval.zsh
# 	Author			- Nick van Jaarsveld
# 	Organisation	- Pro Warehouse
# 	Version			- 1.0
# 	Description
#	Creates a LaunchDeamon in /Library/LaunchDeamons that shuts down the Mac at a predefined schedule
#	Schedule: Configure via script parameters (5 and 6)
#
#	Parameter 4: Preference Domain (without .plist) | nl.prowarehouse.managedworkplace*
# 	Parameter 5: Hour to shutdown (24 hour clock) | 22*
#	Parameter 6: Minute to shutdown | 0*
#
#####################################################################
# GLOBAL VARIABLES
PreferenceDomain="${4:-"nl.prowarehouse.managedworkplace"}"
ShutdownHour="${5:-"22"}"
ShutdownMinute="${6:-"0"}"


#####################################################################
# CORE SCRIPT LOGIC
launchctl bootout system /Library/LaunchDaemons/${PreferenceDomain}.plist

# Create LaunchDeamon
tee /Library/LaunchDaemons/${PreferenceDomain}.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>$PreferenceDomain</string>
	<key>ProgramArguments</key>
	<array>
		<string>/sbin/shutdown</string>
		<string>-h</string>
		<string>now</string>
	</array>
	<key>StartCalendarInterval</key>
	<dict>
		<key>Hour</key>
		<integer>$ShutdownHour</integer>
		<key>Minute</key>
		<integer>$ShutdownMinute</integer>
	</dict>
	<key>RunAtLoad</key>
	<false/>
</dict>
</plist>
EOF

chown root:wheel /Library/LaunchDaemons/${PreferenceDomain}.plist
chmod 644 /Library/LaunchDaemons/${PreferenceDomain}.plist
launchctl bootstrap system /Library/LaunchDaemons/${PreferenceDomain}.plist