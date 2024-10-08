# Dotfiles
It contains my dotfiles, they are used as cross platform configuration and some scripts to restore into my current system and install programs along side.

Supports:
  - Mac OS
  - Ubuntu
  - Windows

## Configuration
You can fork the repository and replace the dotfiles with your configurations and get your customization

## Installation types

- __Dev Install__
  * Google Chrome
  * Docker Desktop
  * Git
  * Hyper JS
  * Zsh and Oh My Zsh
  * Vs Code 

- __Full Install__ (All included in __Dev Install__ plus): 
  * Audacity
  * Vlc
  * Gimp

## Tested Environments

| OS                  | Tested |
| ------------------- |:------:|
| Ubuntu 22.04 (LTS)  | ✅     |
| Windows 10 Pro  | ✅     |
| MacOS Sonoma 14.5  | ✅     |


## Full Installation

### Ubuntu

```bash
bash <(wget -qO- https://raw.githubusercontent.com/Frankeo/dotfiles/refs/heads/main/installations/ubuntu-full.sh)
```

### Windows
Run a _PowerShell_ terminal **As Administrator** . We are experimenting issues with Docker Desktop
```powershell
Invoke-RestMethod -Uri "https://raw.githubusercontent.com/Frankeo/dotfiles/refs/heads/main/installations/windows-full.ps1" | Invoke-Expression
```

### MacOS

```bash
sh <(curl -fsSL https://raw.githubusercontent.com/Frankeo/dotfiles/refs/heads/main/installations/macos-full.sh)
```