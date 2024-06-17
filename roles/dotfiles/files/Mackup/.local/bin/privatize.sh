#!/usr/bin/env bash
#
# Move files into a directory without the read flag
#

PRIVATE_DIR="~/Incomplete/testing"


selected_files=$(osascript 2> /dev/null <<EOF
    set output to ""
    tell application "Finder" to set the_selection to selection
    set item_count to count the_selection
    repeat with item_index from 1 to count the_selection
      if item_index is less than item_count then set the_delimiter to "\n"
      if item_index is item_count then set the_delimiter to ""
      set output to output & ((item item_index of the_selection as alias)'s POSIX path) & the_delimiter
    end repeat
EOF
)

echo $selected_files

# if [[ -n $selected_file ]]; then

#   destination=$(osascript -e 'tell application (path to frontmost application as text)
#     try
#       set myFile to choose file name with prompt "Save file as:"
#       POSIX path of myFile
#     end try
#   end tell')

# fi


# chmod +x $PRIVATE_DIR

# $output=$(mv -v "$file_to_move"))

# display notification "Privatized complete" subtitle "File has been moved"



# if [ -n "$wallpaper_file" ]; then
#   if wal -i "$wallpaper_file" -q; then
#     accent_color=$(jq --raw-output '.colors.color9' < "$HOME/.cache/wal/colors.json")

#     echo "Found color $accent_color"
#     osx-colors set "$accent_color"
#   fi
# fi

# # # reload kitty if it's running
# if pgrep kitty 1>/dev/null; then
#   killall -SIGUSR1 kitty
# fi
