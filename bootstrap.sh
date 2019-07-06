# http://il.luminat.us/blog/2014/04/19/how-i-fully-automated-os-x-with-ansible/

#!/bin/bash

set -e

SRC_DIRECTORY="$HOME/src"
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
    if [[ ! -x /usr/local/bin/brew ]]; then
        echo "Info   | Install   | homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
else
    # Download and install linuxbrew
    if [[ ! -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
        echo "Info   | Install   | linuxbrew"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
        echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >>$HOME/.profile
        source $HOME/.profile
        brew update --force
    fi
fi

# Download and install git
if ! type git > /dev/null 2>&1; then
    echo "Info   | Install   | git"
    brew install git
fi

# Download and install Ansible
if ! type ansible > /dev/null 2>&1; then
    echo "Info   | Install   | ansible"
    brew install ansible
fi

# Make the code directory
mkdir -p $SRC_DIRECTORY

# Clone down ansible
if [[ ! -d $ANSIBLE_DIRECTORY ]]; then
  git clone $ANSIBLE_REPO $ANSIBLE_DIRECTORY
fi

# Provision the box
ansible-playbook --ask-become-pass --become-method=sudo -i $ANSIBLE_DIRECTORY/inventory $ANSIBLE_DIRECTORY/playbook.yml
