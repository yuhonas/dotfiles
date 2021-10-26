#!/bin/sh

RESTIC_REPO=/run/media/$(whoami)/FISK_SSD/restic-repo
FILES_TO_BACKUP="$HOME/Downloads $HOME/Sites $HOME/Documents $HOME/.config $HOME/.local $HOME/Desktop $HOME/.zsh_history"

restic -r $RESTIC_REPO backup $FILES_TO_BACKUP \
--exclude="**/CacheStorage" \
--exclude="**/Trash" \
--exclude="**/Cache" \
--verbose
