#!/usr/bin/env bash
set -e

if [[ "$(uname)" != "Darwin" ]]; then
  echo "❌ This script is macOS-only."
  exit 1
fi

TARGET="/etc/pam.d/sudo_local"

echo "🔐 Enabling Touch ID for sudo (macOS)"

sudo tee "$TARGET" >/dev/null <<'EOF'
# sudo_local: local config file which survives system update
# Enables Touch ID for sudo authentication
auth       sufficient     pam_tid.so
EOF

sudo chmod 644 "$TARGET"

echo "✅ Touch ID for sudo enabled."