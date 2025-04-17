#!/bin/bash
#
# Get latest versions from the SOFA Feed.
#

macosversion=$(curl -s https://sofafeed.macadmins.io/v1/macos_data_feed.json | jq -r '.OSVersions[0].Latest.ProductVersion')
echo "Latest macOS version is: $macosversion"

iosversion=$(curl -s https://sofafeed.macadmins.io/v1/ios_data_feed.json | jq -r '.OSVersions[0].Latest.ProductVersion')
echo "Latest iOS version is: $iosversion"
