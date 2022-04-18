#!/usr/bin/env bash
#
# Select an audio source
#
# depends on
# https://github.com/deweller/switchaudio-osx

current_audio_source=$(SwitchAudioSource -c)
audio_sources=$(SwitchAudioSource -a -t output)

selected_source=$(osascript -e "
tell application \"System Events\"
  set frontmostApplicationName to name of 1st process whose frontmost is true
  activate

  set outputList to every paragraph of \"$audio_sources\"

  choose from list outputList with prompt \"Select an Output\" with title \"Audio Switcher\" default items {\"$current_audio_source\"}
  if the result is not false then
    do shell script \"SwitchAudioSource -s '\" & result & \"'\"
  end if
end tell

tell application frontmostApplicationName
  activate
end tell
")
