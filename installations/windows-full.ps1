Set-ExecutionPolicy Bypass -Scope Process -Force; 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Google Chrome
# choco install googlechrome -y

# Install Docker Desktop
# choco install docker-desktop -y

# Install Hyper
choco install hyper -y

# Install Git and Git Bash
choco install git -y

# Install Oh My Zsh

# Clone dorfiles repo
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-i', '-l', '-c', '"echo $HOME"') -NoNewWindow -Wait
Invoke-WebRequest "https://github.com/Frankeo/dotfiles/archive/refs/heads/main.zip" -OutFile "~\repo.zip"
Expand-Archive -Path "~\repo.zip" -DestinationPath "~\temp"
Move-Item -Path "~\temp\dotfiles-main" -Destination "~"
Rename-Item -path "~\dotfiles-main" -NewName "dotfiles"

# Setup Configs
New-Item -ItemType SymbolicLink -Path "~\.gitconfig" -Target "~\dotfiles\git\.gitconfig"
New-Item -ItemType SymbolicLink -Path "~\.hyper.js" -Target "~\dotfiles\hyper\.hyper.js"

# Install VS Code
# choco install vscode -y

# Install Common Tools
# choco install audacity vlc gimp -y