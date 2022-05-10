#!/bin/bash

# LOOP

printers=($(lpstat -p | awk '{print $2}' | sed '/^$/d'))

for i in "${printers[@]}"
do
	
	echo "$i"
	
done