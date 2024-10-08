#!/bin/sh

echo "Generating a new SSH key for GitHub..."

# Generating a new SSH key
ssh-keygen -t ed25519 -C wangletu57@gmail.com -f ~/.ssh/id_ed25519

# Adding your SSH key to the ssh-agent
bass eval "$(ssh-agent -s)"
/usr/bin/ssh-add --apple-use-keychain ~/.ssh/id_ed25519 # use macos pre-installed version

# Adding your SSH key to your GitHub account
echo "run 'pbcopy < ~/.ssh/id_ed25519.pub' and paste that into GitHub"
