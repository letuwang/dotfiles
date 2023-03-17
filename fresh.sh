#!/bin/sh

echo "Setting up your Mac..."

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Ensure rosetta2 is installed
sudo softwareupdate --install-rosetta

# Ensure homebrew is installed and up-to-date
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew update
fi
brew upgrade

# Ensure fish is installed and set to default shell
if test ! $(which fish); then
  brew install fish
  fish # force fish to generate a default config file
fi
if ! grep -F "$HOMEBREW_PREFIX/bin/fish" /etc/shells; then
  echo "$HOMEBREW_PREFIX/bin/fish" | sudo tee -a /etc/shells;
fi
chsh -s "$HOMEBREW_PREFIX/bin/fish"

# Removes config.fish in default location and symlinks the config.fish file from the .dotfiles
rm -rf $HOME/.config/fish/config.fish
ln -s $HOME/.dotfiles/config.fish $HOME/.config/fish/config.fish

# Install a newer version of bash and add to /etc/shells
brew install bash
if ! grep -F "$HOMEBREW_PREFIX/bin/bash" /etc/shells; then
  echo "$HOMEBREW_PREFIX/bin/bash" | sudo tee -a /etc/shells;
fi

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile
mas signout
read -p "Please sign in to Mac App Store with Apple ID: wangletu57@gmail.com before pressing enter to continue!"
brew bundle --file ./Brewfile_us
brew cleanup

# fix perl
fish -c "PERL_MM_OPT='INSTALL_BASE=$HOME/perl5' cpan local::lib"

# Ensure fisher is installed and up-to-date
if test ! $(which fisher); then
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fi

# setup symlink for fish_plugins file
rm -rf $HOME/.config/fish/fish_plugins
ln -s $HOME/.dotfiles/fish_plugins $HOME/.config/fish/fish_plugins

# Install tools using fisher
fisher update

# Ensure pip is up-to-date
python3 -m pip install --upgrade pip
# Install tools using pip
pip3 install -U radian

# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
