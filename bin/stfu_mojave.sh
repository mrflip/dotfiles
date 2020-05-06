#!/bin/bash

# First check, if Mojave has been downloaded already. If so, delete the setup app.
file="/Applications/Install macOS Mojave.app"
if [ -d "$file" ]
then
    sudo rm -Rf /Applications/Install\ macOS\ Mojave.app
    echo "Mojave deleted."
else
    echo "Mojave not found."
fi

# Deactivate automatic OS update downloads
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool NO
echo "Automatic OS Update downloads deactivated."

exit 0

# Step 1: prevent the update which brings the notification down
softwareupdate --ignore macOSInstallerNotification_GM

echo

# Step 2: delete the file if it's already on the computer
if [[ -d /Library/Bundles/OSXNotification.bundle ]]; then
    echo "OSXNotification.bundle found. Deleting..."
    rm -rf /Library/Bundles/OSXNotification.bundle ||:
else
    echo "OSXNotification.bundle not found."
fi
