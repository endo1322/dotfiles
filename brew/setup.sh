#!/bin/zsh

DOTFILES_DIR=$(cd "$(dirname "$0")/.." && pwd)
BACKUP_DIR="$DOTFILES_DIR/backup"

if command -v brew >/dev/null 2>&1; then
  brew bundle dump --file="$BACKUP_DIR/Brewfile" --force
  echo "Backed up current Brewfile to $BACKUP_DIR/Brewfile"
  brew bundle cleanup --force --file="$DOTFILES_DIR/brew/Brewfile"
  brew bundle --file="$DOTFILES_DIR/brew/Brewfile"
else
  echo "Homebrew not found, skipping brew bundle"
fi
