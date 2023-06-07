#!/bin/bash

idList=("1" "2" "3")

for deviceID in "${idList[@]}"; do
	echo "$deviceID check"
	statusArray[$deviceID]="succes"
done

echo 1: ${statusArray[1]}
echo 2: ${statusArray[2]}
echo 3: ${statusArray[3]}