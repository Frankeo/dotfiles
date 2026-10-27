#!/usr/bin/env bash

set -euo pipefail

if (( EUID == 0 )); then
  printf 'Run this installer as the container user, not root.\n' >&2
  exit 1
fi

if [[ ! -f /etc/os-release ]] || ! command -v apt-get >/dev/null 2>&1; then
  printf 'This installer requires a Debian-based container with apt-get.\n' >&2
  exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
dotfiles_dir="$(cd -- "$script_dir/.." && pwd)"
oh_my_zsh_dir="$HOME/.oh-my-zsh"

packages=()
command -v git >/dev/null 2>&1 || packages+=(git)
command -v zsh >/dev/null 2>&1 || packages+=(zsh)

if (( ${#packages[@]} > 0 )); then
  if ! command -v sudo >/dev/null 2>&1; then
    printf 'Install %s with apt-get or provide passwordless sudo, then rerun.\n' "${packages[*]}" >&2
    exit 1
  fi
  sudo -n apt-get update
  sudo -n apt-get install -y "${packages[@]}"
fi

if [[ ! -d "$oh_my_zsh_dir" ]]; then
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$oh_my_zsh_dir"
fi

zsh_custom="$oh_my_zsh_dir/custom"
mkdir -p "$zsh_custom/themes" "$zsh_custom/plugins"

clone_if_missing() {
  local repository="$1"
  local destination="$2"

  if [[ ! -d "$destination" ]]; then
    git clone --depth 1 "$repository" "$destination"
  fi
}

clone_if_missing https://github.com/romkatv/powerlevel10k.git \
  "$zsh_custom/themes/powerlevel10k"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$zsh_custom/plugins/zsh-syntax-highlighting"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions.git \
  "$zsh_custom/plugins/zsh-autosuggestions"

link_config() {
  local source_path="$1"
  local target_path="$2"
  local backup_path="${target_path}.pre-dotfiles"

  if [[ -L "$target_path" && "$(readlink "$target_path")" == "$source_path" ]]; then
    return
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    if [[ -e "$backup_path" || -L "$backup_path" ]]; then
      printf 'Cannot back up %s: %s already exists.\n' "$target_path" "$backup_path" >&2
      return 1
    fi
    mv -- "$target_path" "$backup_path"
  fi

  ln -s -- "$source_path" "$target_path"
}

link_config "$dotfiles_dir/oh-my-zsh/.zshrc" "$HOME/.zshrc"
link_config "$dotfiles_dir/oh-my-zsh/.p10k.zsh" "$HOME/.p10k.zsh"