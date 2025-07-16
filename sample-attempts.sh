
#!/bin/bash

MAX_ATTEMPTS=3
SLEEP_SECONDS=2

for (( attempt=1; attempt<=MAX_ATTEMPTS; attempt++ )); do
	echo "Attempt $attempt: checking if /usr/local/bin/jamf exists..."
	
	if [ -x "/usr/local/bin/jamf" ]; then
		echo "Jamf binary found!"
		break
	else
		echo "Jamf binary not found."
		if [ "$attempt" -lt "$MAX_ATTEMPTS" ]; then
			echo "Waiting $SLEEP_SECONDS seconds before next attempt..."
			sleep $SLEEP_SECONDS
		fi
	fi
	echo "❌ File was not found after $MAX_ATTEMPTS attempts."
done


exit 1