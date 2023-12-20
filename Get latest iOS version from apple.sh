#!/bin/bash

site="https://support.apple.com/en-us/HT201222"

parseWebPage() {
	
	latestIOSVersion=$(curl -s $site | sed -rn 's/.*The latest version of iOS and iPadOS is[^0-9]*([0-9.]+).*/\1/p' | sed s/.$//)
	echo "Latest iOS version: $latestIOSVersion"
	
}

parseWebPage 


version="17.2"

# Define the regular expression pattern
pattern="^[0-9]+\.[0-9]+(\.[0-9]+)?$"

# Check if the version matches the pattern
if [[ $version =~ $pattern ]]; then
	echo "Valid version number: $version"
else
	echo "Invalid version number: $version"
fi