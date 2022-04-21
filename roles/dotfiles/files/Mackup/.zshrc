export ZSH="$HOME/.oh-my-zsh"

# download znap plugin manager if it's not there yet.
[ -d ~/zsh ] || mkdir ~/zsh
[[ -f ~/zsh/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/zsh/znap

source ~/zsh/znap/znap.zsh  # Start Znap

znap source ohmyzsh/ohmyzsh

# first party plugins
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
znap source ohmyzsh/ohmyzsh plugins/macos
znap source ohmyzsh/ohmyzsh plugins/sudo
znap source ohmyzsh/ohmyzsh plugins/tmux

## Third party plugins
# znap source Aloxaf/fzf-tab
znap source DarrinTisdale/zsh-aliases-exa
znap source MichaelAquilina/zsh-you-should-use
znap source yuhonas/cd-gitroot
znap source wfxr/forgit
znap source zdharma-continuum/fast-syntax-highlighting
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-completions
znap source yuhonas/zsh-ansimotd
# znap source marlonrichert/zsh-autocomplete
# znap source wookayin/fzf-fasd

## My customizations
source $HOME/.oh-my-zsh/custom/custom.zsh

# Local machine customizations (if you need them)
# these won't be comitted to the repo
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi
