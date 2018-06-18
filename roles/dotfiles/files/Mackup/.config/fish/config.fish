# ls aliases
alias ls=exa


# git aliases
alias g=git
alias gco="git checkout"
alias gb="git branch"
alias gst="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gc="git commit --verbose"

# diff
alias diffu="colordiff --unified"
alias diff="colordiff"

# use sublime as the default editor

export EDITOR="subl -w"
export VISUAL="subl -w"

# lesspipe

export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1

# get the weather

alias weather="curl wttr.in/Melbourne"

# use rbevnv shims over local system ruby

export PATH="$HOME/.rbenv/shims:$PATH"
