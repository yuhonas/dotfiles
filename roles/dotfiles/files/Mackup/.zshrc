export ZSH="$HOME/.oh-my-zsh"

# download znap plugin manager if it's not there yet.
[[ -f ~/dotfiles/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/dotfiles/zsh-snap

source ~/dotfiles/zsh-snap/znap.zsh  # Start Znap

# source $ZSH/oh-my-zsh.sh
# export ZSH_CACHE_DIR=$ZSH/cache
znap source ohmyzsh/ohmyzsh


znap source ohmyzsh/ohmyzsh plugins/asdf
# znap source ohmyzsh/ohmyzsh plugins/bundler
znap source ohmyzsh/ohmyzsh plugins/colored-man-pages
znap source ohmyzsh/ohmyzsh plugins/cp
znap source ohmyzsh/ohmyzsh plugins/extract
znap source ohmyzsh/ohmyzsh plugins/fasd
znap source ohmyzsh/ohmyzsh plugins/fzf
znap source ohmyzsh/ohmyzsh plugins/git
znap source ohmyzsh/ohmyzsh plugins/history
znap source ohmyzsh/ohmyzsh plugins/last-working-dir
znap source ohmyzsh/ohmyzsh plugins/osx
znap source ohmyzsh/ohmyzsh plugins/sudo
znap source ohmyzsh/ohmyzsh plugins/tmux
# znap source wookayin/fzf-fasd

## Third party plugins
# znap source Aloxaf/fzf-tab
znap source DarrinTisdale/zsh-aliases-exa
znap source MichaelAquilina/zsh-you-should-use
znap source mollifier/cd-gitroot
znap source wfxr/forgit
znap source zdharma/fast-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions


## My customizations
source $HOME/.oh-my-zsh/custom/custom.zsh

# set the starship prompt if it exists
if (( $+commands[starship] )); then
  # eval "$(starship init zsh)"
  znap eval starship 'starship init zsh --print-full-init'
fi

