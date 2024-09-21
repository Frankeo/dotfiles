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
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"git clone https://github.com/Frankeo/dotfiles.git ~/dotfiles"') -NoNewWindow -Wait

# Install Oh My Zsh
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"cp -r ~/dotfiles/oh-my-zsh/zsh-5.9-2-x86_64/* C:/''Program Files''/Git"') -NoNewWindow -Wait
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"cp ~/dotfiles/oh-my-zsh/.bashrc ~/"') -NoNewWindow -Wait
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"echo yes | sh -c \"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""') -NoNewWindow -Wait

# Setup Configs
New-Item -ItemType SymbolicLink -Path "~\.gitconfig" -Target "~\dotfiles\git\.gitconfig"
New-Item -Path "~\AppData\Roaming" -Name "Hyper" -ItemType "directory"
New-Item -ItemType SymbolicLink -Path "~\AppData\Roaming\Hyper\.hyper.js" -Target "~\dotfiles\hyper\.hyper-windows.js"
# Setup Oh My Zsh config
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k"') -NoNewWindow -Wait
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"') -NoNewWindow -Wait
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions"') -NoNewWindow -Wait
Remove-Item "~\.zshrc"
New-Item -ItemType SymbolicLink -Path "~\.zshrc" -Target "~\dotfiles\oh-my-zsh\.zshrc"
New-Item -ItemType SymbolicLink -Path "~\.p10k.zsh " -Target "~\dotfiles\oh-my-zsh\.p10k.zsh"

# Install Fonts
echo "Install Fonts"
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"(curl -L -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)"') -NoNewWindow -Wait
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"(curl -L -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)"') -NoNewWindow -Wait
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"(curl -L -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)"') -NoNewWindow -Wait
Start-Process -FilePath "$env:ProgramFiles\Git\bin\bash.exe" -ArgumentList @('-c', '"(curl -L -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)"') -NoNewWindow -Wait
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in gci *.ttf)
{
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
        echo $fileName
        dir $file | %{ $fonts.CopyHere($_.fullname) }
    }
}
cp *.ttf c:\windows\fonts\

# Install VS Code
# choco install vscode -y

# Install Common Tools
# choco install audacity vlc gimp -y