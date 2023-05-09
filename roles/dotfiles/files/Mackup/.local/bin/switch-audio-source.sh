#!/usr/bin/env osascript
#
# Select an audio source
#
# @depends on
# https://github.com/deweller/switchaudio-osx

tell application "System Events"
  set frontmostApplicationName to name of 1st process whose frontmost is true
  activate

  set audioSources to do shell script "SwitchAudioSource -a -t output"
  set currentAudioSource to do shell script "SwitchAudioSource -c"

  set outputList to every paragraph of audioSources

  choose from list outputList with prompt "Select an Output" with title "Sound" default items every paragraph of currentAudioSource
  if the result is not false then
    do shell script "SwitchAudioSource -s '" & result & "'"
  end if
end tell

tell application frontmostApplicationName
  activate
end tell
