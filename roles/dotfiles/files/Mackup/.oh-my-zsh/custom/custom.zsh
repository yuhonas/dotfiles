# fzf default options
# https://github.com/junegunn/fzf
# https://minsw.github.io/fzf-color-picker/
export FZF_DEFAULT_OPTS="--reverse
--color=fg:#d0d0d0,hl:#5f87af
--color=fg+:#d0d0d0,hl+:#5fd7ff
--color=info:#afaf87,prompt:#00d6a4,pointer:#af5fff
--color=marker:#87ff00,spinner:#af5fff,header:#87afaf"

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview='less -10 {+} 2>/dev/null'"

# use vim as the default editor
export VISUAL=vim
export EDITOR="$VISUAL"
export TERM=xterm-256color

# color setup for ls
# http://man7.org/linux/man-pages/man1/dircolors.1.html
# eval $(gdircolors ~/.dircolors/dircolors.256dark)

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

# fbr - checkout branch specified or provide a list of all git branches
# including remotes for selection
#
# based on https://github.com/junegunn/fzf/wiki/examples
_fzf_complete_gco() {
    ARGS="$@"
    local branches
    branches=$(git --no-pager branch --all | sed -E 's/remotes\/origin\///')
    echo $ARGS
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
