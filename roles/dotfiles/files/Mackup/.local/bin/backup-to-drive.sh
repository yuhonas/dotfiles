#!/bin/sh

RESTIC_REPO=/run/media/clintp/FISK_USB/restic-repo
FILES_TO_BACKUP="$HOME/Downloads $HOME/Sites $HOME/Documents $HOME/.config
$HOME/.local $HOME/Desktop"

restic -r $RESTIC_REPO backup $FILES_TO_BACKUP --verbose
