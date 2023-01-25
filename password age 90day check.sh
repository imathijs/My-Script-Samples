#!/bin/bash

timeStamp80dBack=$(date -v-90d -u +"%s")
last_user=$( /usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }' )
pwLastChangeEpoch=$(dscl . read /Users/${last_user} accountPolicyData | tail -n +2 | plutil -extract passwordLastSetTime xml1 -o - -- - | sed -n "s/<real>\([0-9]*\).*/\1/p")

if [ $pwLastChangeEpoch -lt $timeStamp80dBack ]; then
	echo "<result>More than 90 Days ago</result>"
else
	echo "<result>Less than 90 Days ago</result>"
fi    

exit 0


