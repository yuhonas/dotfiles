# http://il.luminat.us/blog/2014/04/19/how-i-fully-automated-os-x-with-ansible/

#!/bin/bash

set -e

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
