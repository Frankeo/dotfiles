# Dotfiles

Cross-platform configuration files and installers for macOS, Ubuntu, and Windows.

Fork this repository to customize the configuration. To use your fork, replace `Frankeo/dotfiles` in the installer URL and set `DOTFILES_REPOSITORY` to your fork's clone URL.

## macOS

The installers require an internet connection and an administrator account. Install Apple's Command Line Tools first and wait for setup to finish:

```bash
xcode-select --install
```

Run the installer as your regular user, without `sudo`. It installs Homebrew if needed, clones the configured dotfiles repository to `~/dotfiles`, and backs up existing config files before linking replacements. Homebrew may ask for your administrator password.

### Dev

Installs Chrome, Docker Desktop, Hyper, Visual Studio Code, Zsh, Oh My Zsh, Powerlevel10k, Zsh plugins, and the Meslo font. It also links the Git, Hyper, and Zsh configuration files.

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Frankeo/dotfiles/refs/heads/main/installations/macos-dev.sh)
```

### Full

Includes the Dev install, plus Audacity, VLC, and GIMP.

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Frankeo/dotfiles/refs/heads/main/installations/macos-full.sh)
```

From a local clone, run `bash installations/macos-dev.sh` or `bash installations/macos-full.sh` from the repository root.

## Ubuntu

The Ubuntu Full installer installs the development tools and additional desktop applications.

```bash
bash <(wget -qO- https://raw.githubusercontent.com/Frankeo/dotfiles/refs/heads/main/installations/ubuntu-full.sh)
```

## Windows

Run the Full installer from an elevated PowerShell terminal. Docker Desktop may need additional setup after installation.

```powershell
Invoke-RestMethod -Uri "https://raw.githubusercontent.com/Frankeo/dotfiles/refs/heads/main/installations/windows-full.ps1" | Invoke-Expression
```

## Tested environments

| Operating system | Version | Tested |
| --- | --- | :---: |
| Ubuntu | 22.04 LTS | Yes |
| Windows 10 Pro | 10 | Yes |
| macOS | Sonoma 14.5 | Yes |