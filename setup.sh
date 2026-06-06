#!/bin/bash

set -e

DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)

BACKUP_DIR="$DOTFILES_DIR/backup"
mkdir -p "$BACKUP_DIR"

declare -A symlinks=(
  [".zshrc"]="$HOME/.zshrc"
  [".zprofile"]="$HOME/.zprofile"
  [".gitconfig"]="$HOME/.gitconfig"
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

if command -v brew >/dev/null 2>&1; then
  brew bundle dump --file="$BACKUP_DIR/Brewfile" --force
  echo "Backed up current Brewfile to $BACKUP_DIR/Brewfile"
  brew bundle cleanup --force --file="$DOTFILES_DIR/Brewfile"
  brew bundle --file="$DOTFILES_DIR/Brewfile"
else
  echo "Homebrew not found, skipping brew bundle"
fi

if command -v mise >/dev/null 2>&1; then
  mise install
else
  echo "mise not found, skipping mise install"
fi
