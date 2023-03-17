#!/bin/sh

echo "Setting up your Mac..."

# Ensure homebrew is installed and up-to-date
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew update
fi
brew upgrade

# Ensure fish is installed and added to /etc/shells
if test ! $(which fish); then
  brew install fish
fi
if ! grep -F "$HOMEBREW_PREFIX/bin/fish" /etc/shells; then
  echo "$HOMEBREW_PREFIX/bin/fish" | sudo tee -a /etc/shells;
fi

# Removes config.fish in default location and symlinks the config.fish file from the .dotfiles
rm -rf $HOME/.config/fish/config.fish
ln -s config.fish $HOME/.config/fish/config.fish

# setup brew for fish shell
if test ! $(fish -c "which brew"); then
  echo 'eval "$HOMEBREW_PREFIX/bin/brew shellenv" | source' >> $HOME/.config/fish/config.fish
fi

# Install a newer version of bash and add to /etc/shells
brew install bash
if ! grep -F "$HOMEBREW_PREFIX/bin/bash" /etc/shells; then
  echo "$HOMEBREW_PREFIX/bin/bash" | sudo tee -a /etc/shells;
fi

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile
brew cleanup

# Ensure fisher is installed and up-to-date
if test ! $(which fisher); then
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
else
  fisher update
fi

# setup symlink for fish_plugins file
rm -rf $HOME/.config/fish/fish_plugins
ln -s fish_plugins $HOME/.config/fish/fish_plugins

# Install tools using fisher
fisher install

# Install tools using pip
pip3 install -U radian

# Symlink the Mackup config file to the home directory
ln -s .mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
