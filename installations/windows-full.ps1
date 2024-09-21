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

# Clone dorfiles repo
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-i', '-l', '-c', 'git clone https://github.com/Frankeo/dotfiles.git ~/dotfiles') -NoNewWindow -Wait

# Install Oh My Zsh
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-i', '-l', '-c', 'cp -r ~/dotfiles/oh-my-zsh/zsh-5.9-2-x86_64 C:/Program Files/Git') -NoNewWindow -Wait

# Setup Configs
New-Item -ItemType SymbolicLink -Path "~\.gitconfig" -Target "~\dotfiles\git\.gitconfig"
New-Item -ItemType SymbolicLink -Path "~\.hyper.js" -Target "~\dotfiles\hyper\.hyper-windows.js"

# Install VS Code
# choco install vscode -y

# Install Common Tools
# choco install audacity vlc gimp -y