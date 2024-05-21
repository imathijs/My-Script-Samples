
#!/bin/zsh

#get JSON data from "Apple Software Lookup Service"
JSONData=$(curl -s https://gdmf.apple.com/v2/pmv)

echo "What model do you want to lookup (ex. iPhone15,3):"
read choice

ios_versions=$(echo "$JSONData" | jq -r --arg choice "$choice" '.PublicAssetSets.iOS[] | select(.SupportedDevices | contains([$choice])) | .ProductVersion' | sort -V | tail -n 1)
	
	# Display latest compatible version
	echo "Latest compatible version for $choice:"
	echo "$ios_versions"
	
	