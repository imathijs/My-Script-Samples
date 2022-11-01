#!/bin/bash

# IGNORE OTHER FINDER EXTENSIONS TO FIX DROPBOX FINDER EXTENSION

# TO GET AN OVERVIEW DO COMMMAND: pluginkit -m 
# TO FILTER ONLY FINDER EXTENSIONS, DO COMMAND: pluginkit -m | grep Finder

pluginkit -e ignore -i com.sophos.endpoint.uiserver.FinderScan
pluginkit -e ignore -i com.microsoft.OneDrive.FinderSync
pluginkit -e ignore -i com.adobe.accmac.ACCFinderSync
pluginkit -e ignore -i com.aone.keka.KekaFinderIntegration

# ENABLE DROPBOX
pluginkit -e use -i com.getdropbox.dropbox.fileprovider

exit 0