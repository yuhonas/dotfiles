# ls aliases
alias ls=exa


# git aliases
alias g="git"
alias ga="git add"
alias gco="git checkout"
alias gb="git branch"
alias gst="git status"
alias gd="git diff"
alias gdc="git diff --cached"
alias gc="git commit --verbose"
alias gp="git push"
alias todo="emacsclient ~/Dropbox/ORG/TODO.org"
alias rorc="bundle exec rails c"
alias rors="bundle exec rails s"
alias be="bundle exec"

# diff
alias diff="colordiff"
alias diffu="colordiff --unified"

# rm moves to recycled bin by default
alias rm="trash"

# use sublime as the default editor

export EDITOR="subl -w"
export VISUAL="subl -w"

# lesspipe

export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1

# get the weather

alias weather="curl wttr.in/Melbourne"

# use rbevnv shims over local system ruby

export PATH="$HOME/.rbenv/shims:$HOME/bin:$PATH"
