#!/bin/bash

clear

echo adam 2021-09
echo Tested on "10.15.7 < 11.6"
echo Disable Auto System & AppStore Updates 
sudo echo

echo Disable AppStore Update by Session to 2029 
/usr/bin/defaults write com.apple.appstored LastUpdateNotification -date "2029-12-12 12:00:00 +0000"
/usr/bin/defaults read com.apple.appstored LastUpdateNotification
echo

echo Disable Schedule Update
sudo /usr/sbin/softwareupdate --schedule off
/usr/sbin/softwareupdate --schedule
echo

echo Disable AutoUpdate Commerce
sudo /usr/bin/defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool FALSE
sudo /usr/bin/defaults read /Library/Preferences/com.apple.commerce.plist AutoUpdate
echo

echo Disable AutomaticCheckEnabled AutomaticDownload AutomaticallyInstallMacOSUpdates ConfigDataInstall CriticalUpdateInstall
for i in AutomaticCheckEnabled AutomaticDownload AutomaticallyInstallMacOSUpdates ConfigDataInstall CriticalUpdateInstall
do
	sudo /usr/bin/defaults write /Library/Preferences/com.apple.SoftwareUpdate "$i" -bool FALSE
	sudo /usr/bin/defaults read /Library/Preferences/com.apple.SoftwareUpdate "$i"
done
echo

echo Disable Red Rubbles System Preferences and AppStore
/usr/bin/defaults write com.apple.systempreferences AttentionPrefBundleIDs 0
/usr/bin/defaults read com.apple.systempreferences AttentionPrefBundleIDs
/usr/bin/defaults write com.apple.appstored BadgeCount 0
/usr/bin/defaults read com.apple.appstored BadgeCount
killall Dock
echo

echo Config Done and Exit
echo
