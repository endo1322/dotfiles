autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

if command -v brew >/dev/null 2>&1; then
  brew bundle --file="$DOTFILES_DIR/Brewfile"
else
  echo "Homebrew not found, skipping brew bundle"
fi
