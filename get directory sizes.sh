#!/bin/bash

# CHECK IF RUN BY ROOT
[ "$(whoami)" != "root" ] && exec sudo -- "$0" "$@"

# DIRECTORY PATH VARIABLE
CHECKDIR=<path>

# CHECKS
CHECKFULLPATH=$CHECKDIR/*/
DAY=$(date +%d-%m-%Y)
RUNTIME=$(date +"%T") 
FILE="$CHECKDIR/"$DAY"_Directory_status.txt"

if [ -f $FILE ]; then
	echo "File exits"
fi

echo "Create file: $FILE"
touch "$FILE"

echo -e --------------------- >> "$FILE"
echo -e CHECK DIRECTORY SIZES >> "$FILE"
echo -e Date: $DAY >> "$FILE"
echo -e Time: $RUNTIME >> "$FILE"
echo -e --------------------- >> "$FILE"
for d in $CHECKFULLPATH; do
	du -sh "$d" >> "$FILE"
done
echo -e --------------------- >> "$FILE"
du -sh $CHECKDIR >> "$FILE"
echo -e "" >> "$FILE"

exit 0
