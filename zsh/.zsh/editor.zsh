# ---- Editor settings ---- 

SCRIPTS_DIR="$HOME/dotfiles-and-scripts/scripts"
CONFIG="$HOME/.config/editor-choice"

if [ -f "$CONFIG" ]; then
    source "$CONFIG"
else
    # Run the script once
    bash "$SCRIPTS_DIR/choose_editor.sh"
    source "$CONFIG"
fi
