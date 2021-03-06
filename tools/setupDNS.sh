#!/bin/sh

if [ "$(uname)" == "linux-gnu" ]; then
    echo "\n\nRunning on Linux "
fi

if [ "$(uname)" == "Darwin" ]; then
    echo "\n\nRunning on OSX, checking if dependencies are met."

    if brew ls --versions dnsmasq; then
      # The package is installed we do nothing
      echo "\n\nYes DNSMASQ installed."

      # Stop DNSMASQ service to make sure we can continue with the steps below
      sudo launchctl stop homebrew.mxcl.dnsmasq
    else
      # We know nothing Jon Snow (so we install dnsmasq)
        source brew.sh
    fi

    echo 'address=/.sprd/127.0.0.1' > $(brew --prefix)/etc/dnsmasq.conf

    sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
    sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

    sudo mkdir -v /etc/resolver
    sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/sprd'

    # Make sure DNSMASQ is started
    sudo launchctl start homebrew.mxcl.dnsmasq
fi
