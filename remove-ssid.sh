#!/bin/sh

# Which SSID you want to remove?
SSID=""

# Get the wireless port ID
WirelessPort=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $NF}')

# Run a SSID removal if its present
networksetup -removepreferredwirelessnetwork $WirelessPort "$SSID" 2>/dev/null