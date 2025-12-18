#!/usr/bin/env bash
set -e

if [[ "$(uname)" != "Darwin" ]]; then
  echo "❌ Homebrew is only supported on macOS."
  exit 1
fi

echo "🍺 Setting up Homebrew"

if command -v brew >/dev/null 2>&1; then
  echo "✅ Homebrew already installed"
else
  echo "⬇️  Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v brew >/dev/null 2>&1; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

echo "🔒 Disabling Homebrew analytics"
brew analytics off

echo "✅ Homebrew setup complete"