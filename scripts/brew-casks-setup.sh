casks=(
  bruno cursor docker-desktop firefox google-chrome iterm2 microsoft-teams visual-studio-code whatsapp
)

for cask in "${casks[@]}"; do
  if ! brew list --cask "$cask" &>/dev/null; then
    brew install --cask "$cask"
  else
    echo "$cask ist bereits installiert, überspringe..."
  fi
done