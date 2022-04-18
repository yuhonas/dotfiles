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
    set myFile to choose file with prompt "Select Wallpaper:" of type "public.image"
    POSIX path of myFile
  end try
end tell')


if [ -n "$wallpaper_file" ]; then
  if wal -i "$wallpaper_file" -q; then
    accent_color=$(jq --raw-output '.colors.color9' < "$HOME/.cache/wal/colors.json")

    echo "Found color $accent_color"
    osx-colors set "$accent_color"
  fi
fi

# # reload kitty if it's running
if pgrep kitty 1>/dev/null; then
  killall -SIGUSR1 kitty
fi
