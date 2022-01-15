#!/bin/bash
# 2022-01

clear

OSX=$(sw_vers -productVersion)
OSXMajor=$(sw_vers -productVersion | cut -d'.' -f1)
Computer="macOS $(sw_vers -productVersion) |$(system_profiler SPHardwareDataType | grep Memory | cut -d ':' -f2) |$(system_profiler SPHardwareDataType | grep Cores: | cut -d ':' -f2) Cores |$(system_profiler SPHardwareDataType | grep Speed | cut -d ':' -f2)"

tput bold ; echo adam ; tput sgr0
tput bold ; echo $Computer ; tput sgr0

tput bold ; echo ; echo "🌙 Disable Auto macOS System & AppStore Updates" ; tput sgr0

# Check Minimum System
if [[ "$OSXMajor" -ge 11 ]]; then OSXV=$(echo "$OSXMajor"+5 | bc) ; else OSXV=$(sw_vers -productVersion | cut -d'.' -f2) ; fi
if [ "$OSXV" -ge 14 ] ; then echo macOS "$OSX" Supported > /dev/null ; else echo ; echo macOS "$OSX" not Supported ; echo Tested on "10.14 < 11" && exit ; fi

# Test Password
tput bold ; echo ; echo '🔒' Test Password ; tput sgr0
if sudo echo '🔒'| grep '🔒' > /dev/null  ; then
	echo '🔓' Good Password - You Shall Pass
else
	echo '🔒' Wrong Password - You Shall Not Pass !

	exit
fi

# Disable AppStore Updates on this Session ?
tput bold ; echo ; echo Disable AppStore Updates ; tput sgr0
/usr/bin/defaults write com.apple.appstored LastUpdateNotification -date "3029-12-12 12:00:00 +0000"
/usr/bin/defaults read com.apple.appstored LastUpdateNotification
echo

tput bold ; echo Disable Schedule Updates ; tput sgr0
sudo /usr/sbin/softwareupdate --schedule off > /dev/null
sudo /usr/sbin/softwareupdate --schedule
echo

tput bold ; echo Disable Commerce Updates  ; tput sgr0
sudo /usr/bin/defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool FALSE
sudo /usr/bin/defaults read /Library/Preferences/com.apple.commerce.plist AutoUpdate
echo

tput bold ; echo "Disable AutomaticCheckEnabled & AutomaticDownload & AutomaticallyInstallMacOSUpdates & ConfigDataInstall & CriticalUpdateInstall Updates" ; tput sgr0
for i in AutomaticCheckEnabled AutomaticDownload AutomaticallyInstallMacOSUpdates ConfigDataInstall CriticalUpdateInstall
do
	sudo /usr/bin/defaults write /Library/Preferences/com.apple.SoftwareUpdate "$i" -bool FALSE
	sudo /usr/bin/defaults read /Library/Preferences/com.apple.SoftwareUpdate "$i"
done
echo

tput bold ; echo "Disable Red Bubbles on System Preferences & AppStore" ; tput sgr0
/usr/bin/defaults write com.apple.systempreferences AttentionPrefBundleIDs 0
/usr/bin/defaults read com.apple.systempreferences AttentionPrefBundleIDs
/usr/bin/defaults write com.apple.appstored BadgeCount 0
/usr/bin/defaults read com.apple.appstored BadgeCount
killall Dock
echo

tput bold ; echo Config Done and Exit ; tput sgr0
echo
