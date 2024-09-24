#!/bin/bash

# Install requirements
xcode-select —-install

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Google Chrome
brew install --cask google-chrome

# Install Docker Desktop
brew install --cask docker

# Clone dotfiles repo
sudo git clone https://github.com/Frankeo/dotfiles.git ~/dotfiles

# Setup global git config
ln -fs ~/dotfiles/git/.gitconfig ~/.gitconfig

# Install Hyper
brew install --cask hyper

# Setup Hyper config
ln -fs ~/dotfiles/hyper/.hyper.js ~/.hyper.js 

# Install Fonts
curl -L -o ~/Library/Fonts/'MesloLGS NF Regular'.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -L -o ~/Library/Fonts/'MesloLGS NF Bold'.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -L -o ~/Library/Fonts/'MesloLGS NF Italic'.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -L -o ~/Library/Fonts/'MesloLGS NF Bold Italic'.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

# Install Oh My Zsh
brew install zsh
echo yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Setup Oh My Zsh config
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
ln -fs ~/dotfiles/oh-my-zsh/.zshrc ~/.zshrc
ln -fs ~/dotfiles/oh-my-zsh/.p10k.zsh ~/.p10k.zsh

# Install VS Code
brew install --cask visual-studio-code

# Install Common Tools
brew install --cask audacity vlc gimp

