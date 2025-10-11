# fzf default options
# https://github.com/junegunn/fzf
# https://minsw.github.io/fzf-color-picker/
export FZF_DEFAULT_OPTS="--reverse"

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

# Import pywal colors if they have been exported
# this sets FZF and a whole bunch of color ENV variables to be used in scripts
# see also https://github.com/dylanaraps/wal

PYWAL_COLORS="$HOME/.cache/wal/colors.sh"

if [ -f "$PYWAL_COLORS" ]; then
  source $PYWAL_COLORS
fi

# set TERM if we're not in tmux
# [[ $TMUX = "" ]] && export TERM="xterm-256color"

# IEx persistent history
# https://medium.com/@tylerpachal/iex-persistent-history-5d7d64e905d3
export ERL_AFLAGS="-kernel shell_history enabled"

# truncate the existing command to the first word and wrap it in a tldr call
_tldr() {
  local first_word
  first_word=("${(@s/ /)BUFFER}") # split words based on \s

  # tldr --pager "$first_word[1]"
  BUFFER="tldr $first_word[1]"
  zle accept-line
}
zle -N _tldr

# custom keybinding for tldr help on the current command
bindkey "^[H" _tldr

# ctrl-backspace for backword killword
# bindkey '^H' backward-kill-word

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
# alias -s {rb,go,py,js,txt,md,yaml,yml}=$EDITOR

# use the plain style for bat
# https://github.com/sharkdp/bat
export BAT_STYLE=plain

# Enable zmv for batch file renaming
# https://blog.thecodewhisperer.com/permalink/renaming-magically-with-zmv
autoload zmv
alias mmv='noglob zmv -W'

# Drop the hard coded colors in exa
# https://github.com/ogham/exa/issues/363
# https://github.com/ogham/exa/blob/master/man/exa_colors.5.md
export EXA_COLORS="reset"

# cross platform open command if we can't find an existing one
if (( !$+commands[open] )); then
  alias open=open_command # alias to zsh's cross platform open_command
fi

# if we have kitty then set some handy aliases
# https://sw.kovidgoyal.net/kitty/kittens/icat/
if (( $+commands[kitty] )); then
  alias icat="kitty +kitten icat" # in terminal image preview
  alias d="kitty +kitten diff"
fi

# read from stdin, write to a temp file, open the temp file in a browser, then delete it
# see https://gist.github.com/rchrd2/dc0ecbaeffaf75d253c3711985602d09
stdin2www() {
  tmpfile=$(mktemp).html
  cat > $tmpfile
  open $tmpfile
  #rm $tmpfile
}

# https://stackoverflow.com/questions/4602153/how-do-i-use-wget-to-download-all-images-into-a-single-folder-from-a-url
wget_images() {
  wget -nd -r -A jpeg,jpg,bmp,gif,png $1
}

# set the starship prompt if it exists
# https://github.com/starship/starship
if (( $+commands[starship] )); then
  eval "$(starship init zsh --print-full-init)"
  # FIXME: https://github.com/starship/starship/issues/3553
  # znap eval starship 'starship init zsh --print-full-init'
fi

if (( $+commands[thefuck] )); then
  eval $(thefuck --alias)
fi

# Define the function to traverse the directory stack
function fzf_cd_stack() {
	local dir
	# dir=$(dirs -v | fzf --height 40% --reverse --prompt="Dir Stack> ") && zle -I
	dir=$(dirs -v | gum filter --height 10 --header "Dir Stack> ") && zle -I
	if [[ -n $dir ]]; then
		# Extract the directory path and change to it
		local target_dir
		target_dir=$(echo $dir | awk '{print $2}')
		eval "cd $target_dir"
	fi
	zle reset-prompt
}

zle -N fzf_cd_stack_widget fzf_cd_stack

# Bind the widget to Ctrl+G
bindkey '^G' fzf_cd_stack_widget

fasd-fzf-cd-editor() {
	item="$(fasd -Rl "$1" | fzf -1 -0 --no-sort +m)"
	if [[ -d ${item} ]]; then
		cd "${item}"
	elif [[ -f ${item} ]]; then
		($EDITOR "${item}" </dev/tty)
	else
		return 1
	fi
	zle accept-line
}

zle -N fasd-fzf-cd-editor

if (( $+commands[atuin] )); then
  eval "$(atuin init zsh)"
fi

