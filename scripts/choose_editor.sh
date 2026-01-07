#!/usr/bin/env bash

# ==============================================
# choose_editor.sh
# Interactive editor selector for dotfiles
# Stores choices in ~/.config/editor-choice
# ==============================================

# Config path
CONFIG="$HOME/.config/editor-choice"
mkdir -p "$(dirname "$CONFIG")"

# If config exists, ask before overwriting
if [ -f "$CONFIG" ]; then
    read -rp "Editor config already exists. Overwrite? (y/N): " answer
    case "$answer" in
        [Yy]*) echo "Overwriting existing config..." ;;
        *) echo "Keeping existing config."; exit 0 ;;
    esac
fi

# Editors
EDITORS_KEYS=(nano code cursor)
EDITORS_NAMES=("Nano (terminal)" "VS Code (GUI)" "Cursor (terminal GUI)")

# Filter installed editors
installed_keys=()
installed_names=()
for i in "${!EDITORS_KEYS[@]}"; do
    if command -v "${EDITORS_KEYS[i]}" >/dev/null 2>&1; then
        installed_keys+=("${EDITORS_KEYS[i]}")
        installed_names+=("${EDITORS_NAMES[i]}")
    fi
done

# Fallback if none
if [ ${#installed_keys[@]} -eq 0 ]; then
    echo "❌ No editors found. Falling back to vi."
    cat > "$CONFIG" <<EOF
EDITOR=vi
VISUAL=vi
EOF
    exit 0
fi

# Menu function that sets global variable
select_editor() {
    local prompt="$1"
    local target_var="$2"  # Name of variable to set
    local choice

    echo
    echo "$prompt"
    for i in "${!installed_keys[@]}"; do
        printf "  %d) %s\n" $((i+1)) "${installed_names[i]}"
    done

    while true; do
        read -rp "Enter choice [1-${#installed_keys[@]}]: " choice
        if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#installed_keys[@]} )); then
            # Set the global variable
            eval "$target_var='${installed_keys[$((choice-1))]}'"
            break
        else
            echo "Invalid choice. Try again."
        fi
    done
}

# Run interactive menus
select_editor "Choose your terminal editor (EDITOR):" EDITOR_CHOICE
select_editor "Choose your visual editor (VISUAL):" VISUAL_CHOICE

# Save config with --wait for GUI editors
save_editor() {
    local key="$1"
    local cmd="$2"

    # Append --wait for GUI editors
    case "$cmd" in
        code|cursor)
            echo "$key=\"$cmd --wait\""
            ;;
        *)
            echo "$key=\"$cmd\""
            ;;
    esac
}

# Save config
{
    save_editor "EDITOR" "$EDITOR_CHOICE"
    save_editor "VISUAL" "$VISUAL_CHOICE"
} > "$CONFIG"

echo
echo "✅ Editor configuration saved to $CONFIG"
echo

# Immediately source the config so changes take effect in this shell
# This works only if the script itself is sourced!
if [ "$BASH_SOURCE" = "$0" ]; then
    # running normally: cannot affect parent shell
    echo "To apply changes immediately, run: source $CONFIG"
else
    # script was sourced: update variables in current shell
    source "$CONFIG"
fi