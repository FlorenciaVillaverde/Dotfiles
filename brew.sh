#!/usr/bin/env bash

# Install command-line tools using Homebrew.
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen
brew install php
brew install scala
brew install gmp

# Install configuration files 
brew install mackup

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install other useful binaries.
brew install ack
#brew install exiv2
brew install git
brew install git-lfs
brew install gs
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install zopfli

# iOS
brew install cocoapods
brew install carthage

# Android
brew install cmake
brew install ant
brew install maven
brew install gradle

# Install native apps
brew tap phinze/homebrew-cask
brew install brew-cask

function installcask() {
	if brew cask info "${@}" | grep "Not installed" > /dev/null; then
		brew cask install "${@}"
	else
		echo "${@} is already installed."
	fi
}

# Web
installcask chrome
installcask firefox
installcask tor-browser
installcask lastpass
installcask transmission
installcask visual-studio
installcask whatsapp
installcask discord
installcask spotify

# System
installcask alfred
installcask iterm2
installcask the-unarchiver
installcask virtualbox
installcask duet
installcask vlc
installcask cryptomator
installcask lulu 
installcask nordvpn

# Design
installcask gimp
installcask zeplin

# Messaging 
installcask telegram
installcask signal
installcask lifesize
installcask skype
installcask slack

# IDEs
installcask sublime-text
installcask atom
installcask android-studio
installcask andoid-sdk
installcask andoid-platform-tools
installcask andoid-ndk
installcask andoid-file-transfer
installcask intellij-idea-ce
installcask visual-studio-code
installcask appcode
installcask docker
installcask docker-toolbox
installcask java

# Remove outdated versions from the cellar.
brew cleanup
