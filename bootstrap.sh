#!/bin/bash

# Install Xcode - test for installation from
# https://apple.stackexchange.com/questions/219507/best-way-to-check-in-bash-if-command-line-tools-are-installed
if test xcode-select >&- && xpath=$(xcode-select --print-path) && test -d "$xpath" && test -x "$xpath" ; then
    echo 'Xcode already configured'
else
    echo 'Select "Get Xcode" in the following prompt'
    sleep 2
    /usr/bin/xcode-select --install
    echo 'Once install is completed, run "sudo git" to accept the Xcode'
    echo 'license, and re-run this script'
    exit
fi

# Configure git:
#/usr/bin/git config --global --edit

# Install Homebrew:
if test -x /usr/local/bin/brew ; then
    echo 'Homebrew already installed'
else
    /usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if test -x /usr/local/bin/python ; then
    echo 'Python already installed'
else
    /usr/local/bin/brew install python
    /usr/local/bin/pip install --upgrade pip
fi

if test -x /usr/local/bin/virtualenv ; then
    echo 'Virtualenv already installed'
else
    /usr/local/bin/pip install virtualenv
fi

mkdir -p ${HOME}/virtualenvs
/usr/local/bin/virtualenv ${HOME}/virtualenvs/ansible
${HOME}/virtualenvs/ansible/bin/pip install -r ansible-requirements.txt

${HOME}/virtualenvs/ansible/bin/ansible-playbook -i 127.0.0.1, initial_playbook.yml -K
