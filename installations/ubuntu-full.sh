#!/bin/bash

# Update and Upgrade system
sudo apt update && upgrade -y

# Install requirements for Google Chrome
sudo apt install curl software-properties-common apt-transport-https ca-certificates -y

# Import GPG key from Google Chrome repo
curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/google-chrome.gpg > /dev/null

# Add Google Chrome repo
echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Update system
sudo apt update

# Install Google Chrome
sudo apt install google-chrome-stable

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install Git
sudo apt-get install git-all

# Clone dotfiles repo
git clone https://github.com/Frankeo/dotfiles.git ~/dotfiles

# Setup global git config
ln -fs ~/dotfiles/git/.gitconfig ~/.gitconfig

# Install VS Code
sudo snap install --classic code

# Install Fonts
sudo wget -P /usr/local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
sudo wget -P /usr/local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
sudo wget -P /usr/local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
sudo wget -P /usr/local/share/fonts https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
fc-cache -fv

# Download Hyper
wget https://releases.hyper.is/download/deb

# Install Hyper
sudo dpkg -i deb

# Remove Hyper installer
rm -rf deb

# Setup Hyper config
ln -fs ~/dotfiles/hyper/.hyper.js ~/.hyper.js 

# Install zsh
sudo apt install zsh -y

# Install Oh My Zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" -Y

# Setup Oh My Zsh config
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
ln -fs ~/dotfiles/oh-my-zsh/.zshrc ~/.zshrc
ln -fs ~/dotfiles/oh-my-zsh/.p10k.zsh ~/.p10k.zsh 
