#!/bin/bash

#get JSON data from "Apple Software Lookup Service"
JSONData=$(curl -s https://gdmf.apple.com/v2/pmv)
	
ipad_version=$(echo "$JSONData" | jq -r '.PublicAssetSets.iOS[] | select(.SupportedDevices | contains(["iPad"])) | .ProductVersion')
iphone_version=$(echo "$JSONData" | jq -r '.PublicAssetSets.iOS[] | select(.SupportedDevices | contains(["iPhone"])) | .ProductVersion')
macOS_version=$(echo "$JSONData" | jq -r '.PublicAssetSets.macOS[] | select(.SupportedDevices | contains(["Mac"])) | .ProductVersion')
	
# Extract the latest version for iPads
latest_ipad_version=$(echo "$JSONData" | jq -r '.PublicAssetSets.iOS[] | select(.SupportedDevices | contains(["iPad"])) | .ProductVersion' | sort -V | tail -n 1)
		
# Extract the latest version for iPhones
latest_iphone_version=$(echo "$JSONData" | jq -r '.PublicAssetSets.iOS[] | select(.SupportedDevices | contains(["iPhone"])) | .ProductVersion' | sort -V | tail -n 1)
	
# Extract the latest version for iPhones
latest_macOS_version=$(echo "$JSONData" | jq -r '.PublicAssetSets.macOS[] | select(.SupportedDevices | contains(["Mac"])) | .ProductVersion' | sort -V | tail -n 1)


echo "all iPadOS versions listed in JSON:"
echo "$ipad_version"
echo ""
echo "all iOS versions listed in JSON:"
echo "$iphone_version"
echo ""
echo "all macOS versions listed in JSON:"
echo "$macOS_version"

echo "---"
echo 
echo "Latest iPadOS version: $latest_ipad_version"
echo "Latest iOS version: $latest_iphone_version"
echo "Latest macOS version: $latest_macOS_version"