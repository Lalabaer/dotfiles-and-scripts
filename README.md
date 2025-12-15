# Dotfiles and scripts

Configuration files and scripts to quickly set up my development environment on macOS.  
This repository uses [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles with symbolic links.

---

## 📂 Repository Structure

| Folder     | Description                                                      |
| ---------- | ---------------------------------------------------------------- |
| `git/`     | Git configuration files (e.g., `.gitconfig`)                     |
| `scripts/` | Useful shell scripts for automation and setup                    |
| `zsh/`     | Zsh configuration, including `.zshrc` and custom plugins/scripts |

## 🚀 Setup

1. **Clone the repository**

```bash
git clone https://github.com/Lalabaer/dotfiles-and-scripts.git ~/dotfiles-and-scripts
cd ~/dotfiles-and-scripts
```

2. **Use Stow to link dotfiles to your home directory**

```bash
stow -v -t ~ git
stow -v -t ~ zsh
```

3. **Check the links**

```bash
ls -l ~/.zshrc ~/.zsh
ls -l ~/.gitconfig
```

4. **Removing previously installed links**

Use `stow -D -t ~ <package>` to remove previously installed links if needed.

---

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

## 🔗 References

-   [GNU Stow Documentation](https://www.gnu.org/software/stow/manual/stow.html)
-   [Zsh Official Documentation](https://zsh.sourceforge.io/Doc/)
