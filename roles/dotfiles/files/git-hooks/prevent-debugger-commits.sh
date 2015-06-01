#!/bin/sh

# GIT Pre-Commit hook to prevent silly commits of binding.pry/debugger

if git rev-parse --verify HEAD >/dev/null 2>&1
then
  AGAINST=HEAD
else
  # Initial commit: diff AGAINST an empty tree object
  AGAINST=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Redirect output to stderr.
exec 1>&2

DEBUGGERS_REGEX="binding\.pry|debugger"

DIFF_SEARCH=$(git diff-index --name-only --cached $AGAINST -G $DEBUGGERS_REGEX --exit-code)

if [ "$DIFF_SEARCH" ]; then
  echo
  echo "The following files match the debuggers /$DEBUGGERS_REGEX/ [$0]"
  echo "------------------------------------------------------"
  echo
  printf "\e[31m$DIFF_SEARCH"
  echo
  exit 1
fi
