#!/bin/bash

set -e
set -u
set -o pipefail

echo $(dirname $0)
if [ $# -eq 0 ]; then
  echo "This script expects a url to an image."
  echo "Usage: $0 https://www.example.com/wallpaper.jpg"
  exit 1
fi


FILENAME=$(basename $1)
TEMP_DIR=$(mktemp -d)
TEMP_FILENAME=$TEMP_DIR/$FILENAME
SCRIPT_DIR=$(dirname $(realpath $0))

echo "Downloading $1 => $TEMP_FILENAME"
wget --quiet $1 --output-document $TEMP_FILENAME

echo "Updating using wal and running config update"
wal -i $TEMP_FILENAME -o $SCRIPT_DIR/wal-update-config.sh

echo "Updating alacritty"
$SCRIPT_DIR/alacritty-color-export.sh
