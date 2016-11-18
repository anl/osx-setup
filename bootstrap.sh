#!/bin/bash

# Install Xcode
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