# Yuhonas dotfiles [![ci](https://github.com/yuhonas/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/yuhonas/dotfiles/actions/workflows/ci.yml)

![Screenshot](./screenshot.png)

My overbaked, labour of love dotfiles for both osx / archlinux, _mostly_ everything I need to bootstrap a machine to a productive state

## What's in it?

<!-- BEGIN SUMMARY.md -->

### Shell, terminal & prompt

- [atuin](https://docs.atuin.sh/) — syncable, searchable shell history
- [Ghostty](https://ghostty.org/) — GPU-accelerated terminal
- [Kitty](https://sw.kovidgoyal.net/kitty/) — hackable, scriptable terminal emulator
- [Oh My Zsh](https://ohmyz.sh/) — zsh framework and plugins
- [starship](https://starship.rs/) — fast, cross-shell prompt
- [tmux](https://github.com/tmux/tmux) — terminal multiplexer
- [tmux-plugin-manager (TPM)](https://github.com/tmux-plugins/tpm) — plugin manager for tmux; installs configured plugins
- [zellij](https://zellij.dev/) — terminal workspace / tmux alternative
- [zsh](https://www.zsh.org/) — default interactive shell

### CLI essentials & “modern Unix” tools

- [bash](https://www.gnu.org/software/bash/) — up-to-date Bash shell
- [bat](https://github.com/sharkdp/bat) — syntax-highlighting `cat` replacement
- [coreutils](https://www.gnu.org/software/coreutils/) — GNU core utilities
- [diffutils](https://www.gnu.org/software/diffutils/) — GNU `diff` with color support
- [dua-cli](https://github.com/Byron/dua-cli) — disk usage analyzer (`ncdu` alternative)
- [eza](https://github.com/eza-community/eza) — modern `ls` replacement
- [fd](https://github.com/sharkdp/fd) — user-friendly `find` replacement
- [fzf](https://github.com/junegunn/fzf) — fuzzy finder for files, history, and more
- [gawk](https://www.gnu.org/software/gawk/) — GNU AWK
- [git](https://git-scm.com/) — version control
- [glow](https://github.com/charmbracelet/glow) — terminal markdown viewer
- [ispell](https://www.gnu.org/software/ispell/) — spell checker
- [less](https://www.greenwoodsoftware.com/less/) — pager
- [lesspipe](https://www-zeuthen.desy.de/~friebel/unix/lesspipe.html) — preprocessors for `less` on many file types
- [lsd](https://github.com/lsd-rs/lsd) — `ls` replacement with icons
- [readline](https://tiswww.case.edu/php/chet/readline/rltop.html) — line-editing library
- [ripgrep](https://github.com/BurntSushi/ripgrep) — fast recursive grep
- [rsync](https://rsync.samba.org/) — up-to-date file sync utility
- [tealdeer](https://github.com/dbrgn/tealdeer) — fast `tldr` community man-page summaries
- [The Silver Searcher](https://github.com/ggreer/the_silver_searcher) — code search (`ag`)
- [thefuck](https://github.com/nvbn/thefuck) — suggests fixes after mistyped commands
- [wget](https://www.gnu.org/software/wget/) — non-interactive HTTP downloads
- [zoxide](https://github.com/ajeetdsouza/zoxide) — smart directory jumping (`z`)

### Editors, notes & docs

- [cheat](https://github.com/cheat/cheat) — customizable cheat sheets (like tldr)
- [cheat community cheatsheets](https://github.com/cheat/cheatsheets) — upstream cheat sheet collection
- [Neovim](https://neovim.io/) — modal text editor
- [Obsidian](https://obsidian.md/) — markdown notes and knowledge base
- [pandoc](https://pandoc.org/) — universal document converter
- [Visual Studio Code](https://code.visualstudio.com/) — GUI editor / IDE

### Developer tooling & runtimes

- [awscli](https://aws.amazon.com/cli/) — AWS API command-line interface
- [Bruno](https://www.usebruno.com/) — open-source API client (collections on disk)
- [btop](https://github.com/aristocratos/btop) — resource monitor in the terminal
- [ctags](https://ctags.io/) — tag indexes for source navigation
- [entr](https://eradman.com/entrproject/) — run commands when files change
- [gh](https://cli.github.com/) — GitHub CLI
- [ghq](https://github.com/x-motemen/ghq) — clone and organize remote repos locally
- [git-delta](https://github.com/dandavison/delta) — syntax-highlighted git diffs and pagers
- [gnupg](https://www.gnupg.org/) — encryption and signing
- [just](https://github.com/casey/just) — command runner / makefile alternative
- [lazygit](https://github.com/jesseduffield/lazygit) — terminal UI for git
- [mise](https://mise.jdx.dev/) — polyglot runtime and tool version manager
- [nmap](https://nmap.org/) — network discovery and port scanning
- [OrbStack](https://orbstack.dev/) — fast Docker and Linux VMs
- [pgcli](https://www.pgcli.com/) — Postgres REPL with autocomplete
- [pnpm](https://pnpm.io/) — fast Node package manager
- [Postico](https://eggerapps.at/postico/) — Postgres GUI client
- [redis](https://redis.io/) — in-memory data store for local development
- [ruby-build](https://github.com/rbenv/ruby-build) — Ruby version definitions for mise
- [sqlite](https://www.sqlite.org/) — embedded SQL database
- [uv](https://github.com/astral-sh/uv) — fast Python package installer

### Data, logs, JSON & downloads

- [aria2](https://aria2.github.io/) — lightweight multi-protocol downloader
- [borgbackup](https://www.borgbackup.org/) — deduplicating encrypted backups
- [fx](https://github.com/antonmedv/fx) — interactive JSON explorer
- [gemini-cli](https://github.com/google-gemini/gemini-cli) — Gemini AI from the terminal
- [grex](https://github.com/pemistahl/grex) — generate regexes from example strings
- [imagemagick](https://imagemagick.org/) — image manipulation (e.g. pywal)
- [jdupes](https://github.com/jbruchon/jdupes) — fast duplicate file finder
- [jq](https://jqlang.github.io/jq/) — JSON processor for the shell
- [lnav](https://lnav.org/) — log file viewer with SQL and highlights
- [md5deep](https://github.com/jessek/hashdeep) — hashing and auditing file trees
- [p7zip](https://p7zip.sourceforge.net/) — 7zip archiver
- [poppler](https://poppler.freedesktop.org/) — PDF utilities (used by lesspipe)
- [pv](https://www.ivarch.com/programs/pv.shtml) — pipe viewer (throughput and progress)
- [w3m](https://github.com/tats/w3m) — text-mode web browser
- [xh](https://github.com/ducaale/xh) — HTTPie-style curl alternative

### Python packages

- [csvkit](https://csvkit.readthedocs.io/) — CLI tools for working with CSV files
- [osx-colors](https://github.com/kevinmwl/osx-colors) — change system accent and highlight colors from the CLI
- [posting](https://github.com/darrenburns/posting) — terminal HTTP/API client
- [python-dotenv](https://github.com/theskumar/python-dotenv) — load `.env` files into the environment
- [pywal16](https://github.com/eylles/pywal16) — generate color schemes from wallpapers

### Node packages

- [socket](https://socket.dev/) — CLI for safer dependency auditing

### Web browsers & privacy

- [Brave Browser](https://brave.com/) — Chromium-based browser with ad blocking
- [Tor Browser](https://www.torproject.org/) — anonymous browsing over Tor
- [Zen Browser](https://zen-browser.app/) — privacy- and productivity-focused browser

### Productivity & utilities

- [1Password](https://1password.com/) — password and secrets manager
- [Caffeine](https://www.caffeine-app.net/) — prevent display sleep during long tasks
- DefaultKeyBinding.dict — custom Emacs-style key bindings in Cocoa text fields
- [dockutil](https://github.com/kcrawford/dockutil) — manage Dock items from the CLI
- [Google Drive](https://www.google.com/drive/) — cloud file sync client
- [Karabiner-Elements](https://karabiner-elements.pqrs.org/) — keyboard remapping and complex modifications
- [Raycast](https://www.raycast.com/) — launcher / Spotlight replacement
- [Rectangle](https://rectangleapp.com/) — keyboard-driven window snapping
- [switchaudio-osx](https://github.com/deweller/switchaudio-osx/) — switch audio input/output from the CLI
- [uninstallpkg](https://www.corecode.io/uninstallpkg/) — inspect and remove installer packages
- Zappy — screenshot and screen recording tool

### Media

- [Spotify](https://www.spotify.com/) — music streaming
- [VLC](https://www.videolan.org/) — media player

### Fonts

- Fira Code — monospaced font with ligatures
- Hack — monospaced programming font
- JetBrains Mono — monospaced font tuned for IDEs

### Dotfiles & configuration

- [Mackup](https://github.com/lra/mackup) — symlink application configs into `$HOME`
- osx-defaults.sh — applies system preference defaults (not a package install)

<!-- END SUMMARY.md -->

## Installing

### Prerequisites

1. Xcode Command Line Tools (osx only)
2. [git](https://git-scm.com/)
3. [Ansible](https://www.ansible.com/)
4. [Homebrew](https://brew.sh/)

Use the bootstrap script to install any depedencies and run the
[playbook](./playbook.yml)

```
$ bash <(curl -s https://raw.githubusercontent.com/yuhonas/dotfiles/master/bootstrap.sh)
```

## Running the tests

This repo uses [molecule](https://docs.ansible.com/projects/molecule/) and docker
to lint, provision and test the playbook

```
$ molecule test
```

## Trying it out with Docker

Every test run molecule generates a _minimal_ docker base image which is then published & can be found under [releases](https://github.com/yuhonas/dotfiles/releases)

See also

* [ci.yml](https://github.com/yuhonas/dotfiles/blob/master/.github/workflows/ci.yml)
* [molecule.yml](https://github.com/yuhonas/dotfiles/blob/master/molecule/default/molecule.yml)
