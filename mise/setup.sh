#!/bin/zsh

if command -v mise >/dev/null 2>&1; then
  mise install
else
  echo "mise not found, skipping mise install"
fi
