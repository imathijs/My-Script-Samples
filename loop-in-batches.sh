#!/bin/bash

# Always zero
start=0
# Number of item in the batch
elements=2

# Create array of Serial Numbers for devices in Smart Device Group
serials=(1 2 3 4 5 6 7 8)
# Loop through each serial in array

count=0

for ((i = 0 ; i < ${#serials[@]} ; i++)); do
	serial_list=($(echo ${serials[@]:$start:$elements}))
	
	if ! [  -z "${serial_list}" ]; then
		for ((x = 0 ; x < ${#serial_list[@]} ; x++)); do
			
			echo "${serial_list[$x]} - Test"
			
			((count++))
			
			# Time to wait between sending commands to each device
			sleep 1
			
		done
		echo "Processing next batch of ${elements}"
		
		echo "Refresh bearer token."
		
		# Time to wait between batches
		sleep 5
	else
		echo "Finished Processing"
		break
	fi
	(( start=start+${elements} ))
done