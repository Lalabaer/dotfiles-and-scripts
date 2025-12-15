# ---- Homebrew ----

export BREW_PREFIX="/opt/homebrew"

# Add brew completions
if [ -d "$BREW_PREFIX/share/zsh-completions" ]; then
  fpath=("$BREW_PREFIX/share/zsh-completions" $fpath)
fi

#alliasses
alias brew-get-outdated-casks="brew outdated --cask --greedy --verbose"
alias brew-update-casks="brew upgrade --cask --greedy"
