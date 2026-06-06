#!/bin/bash

set -e

DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)

BACKUP_DIR="$DOTFILES_DIR/backup"
mkdir -p "$BACKUP_DIR"

files=(.zshrc .zprofile .gitconfig)

for file in "${files[@]}"; do
  target="$HOME/$file"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$BACKUP_DIR/$file"
    echo "Backed up $target to $BACKUP_DIR/$file"
  fi
  ln -snf "$DOTFILES_DIR/$file" "$target"
  echo "Linked $file"
done
