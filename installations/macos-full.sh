#!/bin/bash
set -euo pipefail

readonly DOTFILES_REPOSITORY="${DOTFILES_REPOSITORY:-https://github.com/Frankeo/dotfiles.git}"
readonly DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
readonly HOMEBREW_INSTALL_URL="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

<<<<<<< Updated upstream
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
=======
fail() {
	printf 'Error: %s\n' "$1" >&2
	exit 1
}
>>>>>>> Stashed changes

[[ "$(uname -s)" == "Darwin" ]] || fail "This installer is for macOS."
[[ "$(id -u)" -ne 0 ]] || fail "Run this installer as your normal user, not with sudo."
command -v curl >/dev/null 2>&1 || fail "curl is required."
xcode-select -p >/dev/null 2>&1 || fail "Install Xcode Command Line Tools with 'xcode-select --install', finish the installation, then rerun."
command -v git >/dev/null 2>&1 || fail "Git is required. Install Xcode Command Line Tools, then rerun."

if ! command -v brew >/dev/null 2>&1; then
	/bin/bash -c "$(curl -fsSL "$HOMEBREW_INSTALL_URL")"
fi

if command -v brew >/dev/null 2>&1; then
	brew_path="$(command -v brew)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
	brew_path="/opt/homebrew/bin/brew"
elif [[ -x /usr/local/bin/brew ]]; then
	brew_path="/usr/local/bin/brew"
else
	fail "Homebrew installation did not complete successfully."
fi

eval "$("$brew_path" shellenv)"
shellenv_line="eval \"\$($brew_path shellenv)\""
if ! grep -Fqx "$shellenv_line" "$HOME/.zprofile" 2>/dev/null; then
	printf '\n%s\n' "$shellenv_line" >> "$HOME/.zprofile"
fi

if [[ -d "$DOTFILES_DIR/.git" ]]; then
	printf 'Using dotfiles at %s\n' "$DOTFILES_DIR"
elif [[ -e "$DOTFILES_DIR" ]]; then
	fail "$DOTFILES_DIR exists but is not a Git repository. Set DOTFILES_DIR to another path or move the existing directory."
else
	git clone "$DOTFILES_REPOSITORY" "$DOTFILES_DIR"
fi

link_file() {
	local source_file="$1"
	local destination="$2"
	local backup

	[[ -e "$source_file" ]] || fail "Configuration file not found: $source_file"
	mkdir -p "$(dirname "$destination")"

	if [[ -L "$destination" ]] && [[ "$(readlink "$destination")" == "$source_file" ]]; then
		return
	fi

	if [[ -e "$destination" || -L "$destination" ]]; then
		backup="${destination}.backup.$(date +%Y%m%d%H%M%S).$$"
		mv "$destination" "$backup"
		printf 'Backed up %s to %s\n' "$destination" "$backup"
	fi

	ln -s "$source_file" "$destination"
}

clone_if_missing() {
	local repository="$1"
	local destination="$2"

	if [[ ! -d "$destination" ]]; then
		git clone "$repository" "$destination"
	fi
}

"$brew_path" install zsh
"$brew_path" install --cask google-chrome docker hyper visual-studio-code

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
	RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

clone_if_missing "https://github.com/romkatv/powerlevel10k.git" "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
clone_if_missing "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
clone_if_missing "https://github.com/zsh-users/zsh-autosuggestions.git" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/hyper/.hyper.js" "$HOME/.hyper.js"
link_file "$DOTFILES_DIR/oh-my-zsh/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/oh-my-zsh/.p10k.zsh" "$HOME/.p10k.zsh"

mkdir -p "$HOME/Library/Fonts"
curl -fL --retry 3 -o "$HOME/Library/Fonts/MesloLGS NF Regular.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
curl -fL --retry 3 -o "$HOME/Library/Fonts/MesloLGS NF Bold.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
curl -fL --retry 3 -o "$HOME/Library/Fonts/MesloLGS NF Italic.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
curl -fL --retry 3 -o "$HOME/Library/Fonts/MesloLGS NF Bold Italic.ttf" "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"

"$brew_path" install --cask audacity vlc gimp

printf '\nFull macOS setup is complete. Restart your terminal to load the shell configuration.\n'

