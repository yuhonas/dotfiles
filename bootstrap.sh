# http://il.luminat.us/blog/2014/04/19/how-i-fully-automated-os-x-with-ansible/

#!/bin/bash

set -e

SRC_DIRECTORY="$HOME/src"
ANSIBLE_DIRECTORY="$SRC_DIRECTORY/ansible"
ANSIBLE_REPO="git@github.com:yuhonas/mac-dev-playbook.git"
ANSIBLE_NOCOWS=1 

# Download and install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
fi

# Download and install Homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Info   | Install   | homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Modify the PATH
export PATH=/usr/local/bin:$PATH

# Download and install git
if [[ ! -x /usr/local/bin/git ]]; then
    echo "Info   | Install   | git"
    brew install git
fi

# Download and install Ansible
if [[ ! -x /usr/local/bin/ansible ]]; then
    echo "Info   | Install   | ansible"
    brew install ansible
fi

# Make the code directory
mkdir -p $SRC_DIRECTORY

# Clone down ansible
if [[ ! -d $ANSIBLE_DIRECTORY ]]; then
  git clone $ANSIBLE_REPO $ANSIBLE_DIRECTORY
fi

# # Provision the box
ansible-playbook --ask-sudo-pass -i $ANSIBLE_DIRECTORY/inventory $ANSIBLE_DIRECTORY/playbook.yml