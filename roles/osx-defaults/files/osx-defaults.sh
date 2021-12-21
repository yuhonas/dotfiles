#!/bin/bash

# References
# ----------------
# https://github.com/donnemartin/dev-setup/blob/master/osx.sh
# https://github.com/herrbischoff/awesome-osx-command-line/blob/master/README.md
# https://github.com/arrelid/preferences/blob/master/defaults.sh
# https://github.com/kevinSuttle/macOS-Defaults


## Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

## Enable repeating keys
# https://www.howtogeek.com/267463/how-to-enable-key-repeating-in-macos/
# defaults write -g ApplePressAndHoldEnabled -bool false

## Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

## Set keyboard repeat rate to "damn fast".
# defaults write NSGlobalDomain KeyRepeat -int 2

## Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

## Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

## Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

## Show Full Path in Finder Title
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

## Set current Folder as Default Search Scope
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

## New Finder windows points to home
defaults write com.apple.finder NewWindowTarget -string "PfHm"

## Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

## Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

## Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

## Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

## Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

## Change screenshot location
defaults write com.apple.screencapture location ~/Downloads

## Finder: show hidden files by default
# Use CMD-Shift . to show hidden files
# defaults write com.apple.finder AppleShowAllFiles -bool true

## Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

## Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

## Top right screen corner → Start screen saver
# defaults write com.apple.dock wvous-tr-corner -int 5
# defaults write com.apple.dock wvous-tr-modifier -int 0

## Bottom right screen corner → Put display to sleep
# defaults write com.apple.dock wvous-br-corner -int 10
# defaults write com.apple.dock wvous-br-modifier -int 0

## Always show scrollbars
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

## Use a dark menu bar / dock
# defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Autohide the dock - http://www.idownloadblog.com/2015/02/14/auto-hide-dock-no-delay-mac/
# defaults write com.apple.dock autohide -bool true

## Disable sounds effects for user interface changes
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 0

## Set alert volume to 0
defaults write NSGlobalDomain com.apple.sound.beep.volume -float 0.0

## Disable natural scrolling
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

## Don't want Photos.app to open up as soon as you plug something in?
defaults write com.apple.ImageCapture disableHotPlug -bool YES

## Show battery percentage remaining in menu bar
## TODO: Doesn't seem to be working in MacOS Monterey
#defaults write com.apple.menuextra.battery ShowPercent YES

# Disable Notification Center and remove the menu bar icon
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

## Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

## Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

## Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable guest account logins
# https://gist.github.com/justinpawela/8a924f36f86bac2b563bf6832eefff25

# dscl . -delete /Users/Guest
# security delete-generic-password -a Guest -s com.apple.loginwindow.guest-account -D "application password" /Library/Keychains/System.keychain

# defaults write com.apple.loginwindow GuestEnabled -bool FALSE
# defaults write SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool false
# defaults write com.apple.AppleFileServer guestAccess -bool false

## Enable secondary (right button mouse click)
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton

## Disable smart quotes/dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Set key repeat for vscode
# See https://github.com/VSCodeVim/Vim#mac-setup
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
