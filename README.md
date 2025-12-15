# Dotfiles and scripts

## Usage

-   `stow -v -t ~ git`
-   `stow -v -t ~ zsh`

## Troubleshooting: Zsh `compinit` Insecure Directories

If you see this error when starting Zsh:

Run the following commands to check and fix insecure directories:

```bash
# List insecure directories
compaudit

# Remove write permissions for group and others
sudo chmod go-w <directory>    # e.g., sudo chmod go-w /opt/homebrew/share

# Verify again
compaudit

# Restart Zsh to apply changes
exec zsh
```
