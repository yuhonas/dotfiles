#!/bin/bash
# http://il.luminat.us/blog/2014/04/19/how-i-fully-automated-os-x-with-ansible/

set -e

SRC_DIRECTORY="$HOME/dotfiles"
ANSIBLE_DIRECTORY="$SRC_DIRECTORY/ansible"
ANSIBLE_REPO="https://github.com/yuhonas/dotfiles.git"
export ANSIBLE_NOCOWS=1

if [ "$(uname)" == "Darwin" ]; then
	# Download and install Command Line Tools
	if [[ ! -x /usr/bin/gcc ]]; then
		echo "Info   | Install   | xcode"
		xcode-select --install
	fi

	# Download and install homebrew
  if ! type brew >/dev/null 2>&1; then
		echo "Info   | Install   | homebrew"
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	eval $(/opt/homebrew/bin/brew shellenv)
else
	# Download and install linuxbrew
	if [[ ! -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
		# archlinux
		sudo pacman --sync --refresh --noconfirm --needed \
			base-devel \
			git ca-certificates \
			curl \
			git \
			libxcrypt-compat # for homebrew installation which installs ruby 2.6.8

		# set locale
		sudo localedef -i en_US -f UTF-8 en_US.UTF-8

		echo "Info   | Install   | linuxbrew"
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>$HOME/.bash_profile
	fi
	eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

brew update

# Install git
if ! type git >/dev/null 2>&1; then
	echo "Info   | Install   | git"
	brew install git
fi

# Install ansible
# Assumes system python is installed
if ! type ansible >/dev/null 2>&1; then
	echo "Info   | Install   | ansible"
  python3 -m pip install pipx
  python3 -m pipx install --install-deps ansible
fi

# Make the code directory
mkdir -p $SRC_DIRECTORY

# Clone down ansible
if [[ ! -d $ANSIBLE_DIRECTORY ]]; then
	git clone $ANSIBLE_REPO $ANSIBLE_DIRECTORY

	# if we're part of a build we should checkout the supplied SHA
	if [[ -n "$GITHUB_SHA" ]]; then
		git checkout "$GITHUB_SHA"
	fi
fi

if [[ -z "$NO_PROVISION" ]]; then
	# Provision the box
	python3 -m ansible-playbook -i $ANSIBLE_DIRECTORY/inventory $ANSIBLE_DIRECTORY/playbook.yml
fi
