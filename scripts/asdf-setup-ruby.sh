#!/bin/bash
set -e  # Exit on error

# Load asdf in the current shell
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  source "$HOME/.asdf/asdf.sh"
else
  echo "Error: asdf is not installed. Please run setup-asdf.sh first."
  exit 1
fi

# Ruby version to install
RUBY_VERSION="3.3.2"

# Add Ruby plugin if not already added
if ! asdf plugin-list | grep -q "ruby"; then
  echo "Adding Ruby plugin..."
  asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
else
  echo "Ruby plugin already exists."
fi

# Install Ruby version if not installed
if ! asdf list ruby | grep -q "$RUBY_VERSION"; then
  echo "Installing Ruby $RUBY_VERSION..."
  asdf install ruby "$RUBY_VERSION"
else
  echo "Ruby $RUBY_VERSION is already installed."
fi

# Set global version
asdf global ruby "$RUBY_VERSION"
echo "Ruby $RUBY_VERSION set as global."