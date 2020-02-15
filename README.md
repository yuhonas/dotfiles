# Yuhonas dotfiles ![](https://github.com/yuhonas/dotfiles/workflows/ci/badge.svg)

![Screenshot](./screenshot.png)

## What's in the box

[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) with [antigen](https://github.com/zsh-users/antigen) for plugin management with a sprinkling of 256 color's using [exa](https://github.com/ogham/exa) all rendered using [hyper](https://hyper.is/)

### A sane set of Mac defaults

* Autohide the dock
* Avoid creating .DS_Store files on network volumes
* Bottom left screen corner → Start screen saver
* Change screenshot location
* Disable natural scrolling
* Disable sounds effects for user interface changes
* Disable the warning when changing a file extension
* Don't open Photos.app as soon as you plug something in
* Enable full keyboard access for all controls
* Enable repeating keys
* Expand save panel by default
* Finder: show all filename extensions
* Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
* Keep folders on top when sorting by name
* New Finder windows points to home
* Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
* Set alert volume to 0
* Set current Folder as Default Search Scope
* Set keyboard repeat rate to "damn fast".
* Show Full Path in Finder Title
* Use a dark menu bar / dock
* Use list view in all Finder windows by default

### Bootstrapped with your favourite applications

* alfred
* 1password
* dropbox
* evernote
* flux
* google-chrome
* handbrake
* libreoffice
* rectangle
* skype
* spotify
* torbrowser
* uninstallpkg

### A handy set of system packages

* aria2
* asdf
* coreutils
* ctags
* dos2unix
* fasd
* fdupes
* figlet
* fpp
* gnupg
* hr
* htop-osx
* httpie
* jq
* lesspipe
* lnav
* md5deep
* ncdu
* nmap
* pandoc
* poppler
* progress
* pv
* qt
* readline
* rename
* ruby-build
* the_silver_searcher
* tig
* tldr
* tmux
* tree
* unrar
* wget
* zsh

### A better Mac quicklook

The following quicklook plugins

* betterzipql
* qlcolorcode
* qlmarkdown
* qlstephen
* quicklook-json

## Installation

### Prerequisites

1. Xcode Command Line Tools
1. Homebrew
1. Git
1. Ansible

Use the bootstrap script to install any depedencies and run the playbook

```
$ bash <(curl -s https://raw.githubusercontent.com/yuhonas/mac-dev-playbook/master/bootstrap.sh)
````
