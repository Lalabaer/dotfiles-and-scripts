#!/bin/bash
set -e  # Exit on error

# Load asdf in the current shell
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  source "$HOME/.asdf/asdf.sh"
else
  echo "Error: asdf is not installed. Please run setup-asdf.sh first."
  exit 1
fi

# Node.js version to install
NODE_VERSION="20.5.1"

# Add Node.js plugin if not already added
if ! asdf plugin-list | grep -q "nodejs"; then
  echo "Adding Node.js plugin..."
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
else
  echo "Node.js plugin already exists."
fi

# Install Node.js version if not installed
if ! asdf list nodejs | grep -q "$NODE_VERSION"; then
  echo "Installing Node.js $NODE_VERSION..."
  asdf install nodejs "$NODE_VERSION"
else
  echo "Node.js $NODE_VERSION is already installed."
fi

# Set global version
asdf global nodejs "$NODE_VERSION"
echo "Node.js $NODE_VERSION set as global."

# Reshim to ensure binaries like yarn are available
echo "Running asdf reshim for Node.js..."
asdf reshim nodejs