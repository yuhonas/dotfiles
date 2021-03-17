#!/bin/bash

set -e
set -u
set -o pipefail

# use a rofi dark theme if pywall has generated one
WALL_ROFI_THEME="$HOME/.cache/wal/colors-rofi-dark.rasi"
ROFI_DIR=$HOME/.config/rofi

WALL_WAYBAR_THEME="$HOME/.cache/wal/colors-waybar.css"
WAYBAR_DIR=$HOME/.config/waybar

if [[ -f $WALL_ROFI_THEME ]]; then
  [ -d $ROFI_DIR ] || mkdir -p $ROFI_DIR
  cp -v $WALL_ROFI_THEME $ROFI_DIR/config.rasi
fi

# load theme into env variables / also themes FZF
# see https://github.com/dylanaraps/pywal/wiki/Customization#user-content-scripting-files
. $HOME/.cache/wal/colors.sh

# add custom css for waybar
if [[ -f $WALL_WAYBAR_THEME ]]; then
  [ -d $WAYBAR_DIR ] || mkdir -p $WAYBAR_DIR
  cp -v $WALL_WAYBAR_THEME $WAYBAR_DIR/style.local.css
fi

# reload sway if we have it
if type swaymsg > /dev/null 2>&1; then
  swaymsg reload
fi
