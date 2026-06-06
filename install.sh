#!/bin/bash

set -e

DOTFILES_DIR=$(cd "$(dirname "$0")" && pwd)

files=(.zshrc .zprofile .gitconfig)

for file in "${files[@]}"; do
  target="$HOME/$file"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "${target}.bak"
    echo "Backed up $target to ${target}.bak"
  fi
  ln -snf "$DOTFILES_DIR/$file" "$target"
  echo "Linked $file"
done
