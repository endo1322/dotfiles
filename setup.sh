#!/bin/bash

set -e

DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)
BACKUP_DIR="$DOTFILES_DIR/backup"

mkdir -p "$BACKUP_DIR"

declare -A symlinks=(
  ["zsh/.zshrc"]="$HOME/.zshrc"
  ["zsh/.zprofile"]="$HOME/.zprofile"
  ["git/.gitconfig"]="$HOME/.gitconfig"
  ["mise/config.toml"]="$HOME/.config/mise/config.toml"
)

for src in "${!symlinks[@]}"; do
  target="${symlinks[$src]}"
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$BACKUP_DIR/$(basename "$target")"
    echo "Backed up $target"
  fi
  ln -snf "$DOTFILES_DIR/$src" "$target"
  echo "Linked $src"
done

bash "$DOTFILES_DIR/brew/setup.sh"
bash "$DOTFILES_DIR/mise/setup.sh"
