# fzf default options
# https://github.com/junegunn/fzf
# https://minsw.github.io/fzf-color-picker/
export FZF_DEFAULT_OPTS="--reverse"
# --color=fg:#d0d0d0,hl:#5f87af
# --color=fg+:#d0d0d0,hl+:#5fd7ff
# --color=info:#afaf87,prompt:#00d6a4,pointer:#af5fff
# --color=marker:#87ff00,spinner:#af5fff,header:#87afaf"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview='less -10 {+} 2>/dev/null'"

# use neovim as the default editor
export VISUAL=nvim
export EDITOR="$VISUAL"
alias vi="nvim"
alias vim="nvim"

# set TERM if we're not in tmux
[[ $TMUX = "" ]] && export TERM="xterm-256color"

# IEx persistent history
# https://medium.com/@tylerpachal/iex-persistent-history-5d7d64e905d3
export ERL_AFLAGS="-kernel shell_history enabled"

# truncate the existing command to the first word and wrap it in a tldr call
_tldr() {
  local first_word
  first_word=("${(@s/ /)BUFFER}") # split words based on \s

  BUFFER="tldr $first_word[1]"
  zle accept-line
}
zle -N _tldr

# custom keybindings for fast directory exploration
bindkey -s "^[l" "ls -al^J"  # alt-l shortcut to listing a directory
bindkey -s "^[r" "ranger^J"  # alt-r shortcut to file explorer
# custom keybinding for tldr help on the current command
bindkey "^[H" _tldr

# ctrl-backspace for backword killword
bindkey '^H' backward-kill-word


# less input pre-processing through lesspipe
# https://manpages.debian.org/jessie/less/lesspipe.1.en.html
export LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
export LESS_ADVANCED_PREPROCESSOR=1

# cd-gitroot alias
# https://github.com/mollifier/cd-gitroot
alias cdu='cd-gitroot'

# get the weather
alias weather="curl wttr.in/Melbourne"

# Setup frequent dirs in the CDPATH so we can cd to them from anywhere
# https://thoughtbot.com/blog/cding-to-frequently-used-directories-in-zsh
setopt auto_cd
cdpath=($HOME/Sites $HOME/src)

# Setup a zsh suffix alias to allow fast editing using just the filename
# https://opensource.com/article/18/9/tips-productivity-zsh
alias -s {rb,go,py,js,txt,md,yaml,yml}=$EDITOR

# use the plain style for bat
# https://github.com/sharkdp/bat
export BAT_STYLE=plain

# Enable zmv for batch file renaming
# https://blog.thecodewhisperer.com/permalink/renaming-magically-with-zmv
autoload zmv
alias mmv='noglob zmv -W'

# cross platform open command if we can't find an existing one
if (( !$+commands[open] )); then
  alias open=open_command # alias to zsh's cross platform open_command
fi

# shortcut for emacs org mode based todo list
# assumes an emacs daemon is running see
# https://www.emacswiki.org/emacs/EmacsAsDaemon
alias todo="emacsclient $HOME/TODO.org"

# fbr - checkout branch specified or provide a list of all git branches
# including remotes for selection
#
# based on https://github.com/junegunn/fzf/wiki/examples
_fzf_complete_gco() {
    ARGS="$@"
    local branches
    branches=$(git --no-pager branch --all | sed -E 's/remotes\/origin\///')

    if [[ $ARGS == 'gco'* ]]; then
        _fzf_complete "--reverse --multi" "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

# read from stdin, write to a temp file, open the temp file in a browser, then delete it
# see https://gist.github.com/rchrd2/dc0ecbaeffaf75d253c3711985602d09
stdin2www() {
  tmpfile=$(mktemp).html
  cat > $tmpfile
  open $tmpfile
  #rm $tmpfile
}

