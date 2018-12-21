#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# BEGIN ANSIBLE MANAGED BLOCK

# fasd aliases see - https://github.com/clvv/fasd

alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection

# load fzf completion and key bindings

export FZF_DEFAULT_OPTS='--height 40% --reverse'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# git branch via fzf
# TODO: this should be an zsh completion

unalias gb

gb() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m ) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# git aliases

alias gst='git status'
alias gj='git jira'
alias gd='git diff'
alias gdc='git diff --cached'

# use sublime as the default editor

export EDITOR='subl -w'
export VISUAL='subl -w'

# set our prompt

autoload -Uz promptinit
promptinit
prompt pure

# heroku aliases

alias h="heroku"
alias hl="heroku logs -t"
alias hc="heroku run console"
alias hr="heroku run"
alias hp="heroku ps"
alias hnr="heroku addons:open newrelic"
alias be="bundle exec"

# ls aliases

eval $(gdircolors ~/.dircolors/dircolors.256dark)

alias ls='exa' # use exa instead of ls
alias ll='exa -al'

# lesspipe

export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1

# get the weather

alias weather="curl wttr.in/Melbourne"

# iTerm 2 Integration see https://www.iterm2.com/documentation-shell-integration.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# END ANSIBLE MANAGED BLOCK
