#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  # Update Homebrew recipes
  brew update
fi

# Check for fish and install if we don't have it
if test ! $(which fish); then
  brew install fish
fi

# Removes config.fish in default location and symlinks the config.fish file from the .dotfiles
rm -rf $HOME/.config/fish/config.fish
ln -s config.fish $HOME/.config/fish/config.fish

# setup brew for fish shell
if test ! $(fish -c "which brew"); then
  echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> $HOME/.config/fish/config.fish
  eval $(/opt/homebrew/bin/brew shellenv)
fi

# Check for fisher and install if we don't have it
if test ! $(which fisher); then
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fi

# install fisher plugins
fisher install jorgebucaran/nvm.fish
fisher install franciscolourenco/done

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Install tools that requires python
pip3 install -U radian

# Symlink the Mackup config file to the home directory
ln -s .mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
