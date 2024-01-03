#!/usr/bin/env bash
#
# Set the systems wallpaper and accent colors based on a file selection prompt
#
# depends on
# https://github.com/dylanaraps/pywal
# https://github.com/stedolan/jq
# https://github.com/yuhonas/osx-colors/

wallpaper_file=$(osascript -e 'tell application (path to frontmost application as text)
  try
  set imageFile to (choose file with prompt "Select an image file:" of type "public.image") as text
  end try
end tell

tell application "System Events"
	repeat with desktopIndex from 1 to count of desktops
		tell desktop desktopIndex
			set picture to imageFile
		end tell
	end repeat
end tell

return POSIX path of imageFile')

if [ -n "$wallpaper_file" ]; then
  # do not set the walpaper using wal, it's broken in macos sonora
  # see https://github.com/dylanaraps/pywal/issues/715
  if wal -n -i "$wallpaper_file" -q; then
    accent_color=$(jq --raw-output '.colors.color9' < "$HOME/.cache/wal/colors.json")

    echo "Found color $accent_color"
    osx-colors set "$accent_color"
  fi
fi

# # reload kitty if it's running
if pgrep kitty 1>/dev/null; then
  killall -SIGUSR1 kitty
fi
