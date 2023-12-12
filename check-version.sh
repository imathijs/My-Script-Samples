#!/bin/bash

# Function to check if the name contains a version pattern
check_version() {
	local name="$1"
	local version_pattern="([0-9]+\.){2}[0-9]+"
	
	
	if [[ $name =~ $version_pattern ]]; then
		echo "The name '$name' contains a version pattern."
	else
		echo "The name '$name' does not contain the expected version pattern."
	fi
}

# Example usage
name1="iOS 17 + not 2.18.1]"
name2="Name.app 3.5.0"
name3="No version here"

# Call the function with different names
check_version "$name1"
check_version "$name2"
check_version "$name3"
