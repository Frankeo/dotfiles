Set-ExecutionPolicy Bypass -Scope Process -Force; 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Google Chrome
# choco install googlechrome -y

# Install Docker Desktop
# choco install docker-desktop -y

# Install Hyper
choco install hyper -y

# Install Git
choco install git -y

# Install Oh My Zsh

# Clone dorfiles repo
Invoke-WebRequest "https://github.com/Frankeo/dotfiles/archive/refs/heads/main.zip" -OutFile "C:\Temp\repo.zip"
Expand-Archive -Path "C:\Temp\repo.zip" -DestinationPath "~/dotfiles"

# Setup Configs
New-Item -ItemType SymbolicLink -Path "~/dotfiles/git/.gitconfig" -Target "~/.gitconfig"
New-Item -ItemType SymbolicLink -Path "~/dotfiles/hyper/.hyper.js" -Target "~/.hyper.js"

# Install VS Code
# choco install vscode -y

# Install Common Tools
# choco install audacity vlc gimp -y