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

## 📜 Scripts

The `scripts/` folder contains automation scripts for setting up your development environment. These scripts are designed to be run in a specific order to ensure dependencies are met.

### Available Scripts

| Script                         | Description                                                                 |
| ------------------------------ | --------------------------------------------------------------------------- |
| `brew-setup.sh`                | Installs Homebrew package manager (required for other scripts)              |
| `brew-formulae-setup.sh`       | Installs essential command-line tools via Homebrew (asdf, git, stow, etc.)  |
| `brew-casks-setup.sh`          | Installs GUI applications via Homebrew Cask (Cursor, VS Code, Docker, etc.) |
| `asdf-setup-node.sh`           | Sets up Node.js (v20.5.1) using asdf version manager                        |
| `asdf-setup-ruby.sh`           | Sets up Ruby (v3.3.2) using asdf version manager                            |
| `enable-touchid-sudo-macos.sh` | Enables Touch ID authentication for sudo commands on macOS                  |

### Execution Order

The scripts should be run in the following order to ensure all dependencies are properly installed:

1. **`brew-setup.sh`** (Required first)

    - Installs Homebrew, which is required for all other scripts
    - Sets up Homebrew environment variables
    - Disables Homebrew analytics

2. **`brew-formulae-setup.sh`** (Requires: `brew-setup.sh`)

    - Installs essential command-line tools including:
        - `asdf` (version manager)
        - `git`, `stow`, `wget`
        - Docker CLI tools
        - Zsh completions
        - Other development utilities

3. **`brew-casks-setup.sh`** (Requires: `brew-setup.sh`)

    - Installs GUI applications:
        - Development tools: Cursor, VS Code, iTerm2
        - Browsers: Firefox, Google Chrome
        - Communication: Microsoft Teams, WhatsApp
        - Other: Bruno, Docker Desktop

4. **`asdf-setup-node.sh`** (Requires: `brew-formulae-setup.sh`)

    - Adds Node.js plugin to asdf
    - Installs Node.js v20.5.1
    - Sets it as the global version

5. **`asdf-setup-ruby.sh`** (Requires: `brew-formulae-setup.sh`)

    - Adds Ruby plugin to asdf
    - Installs Ruby v3.3.2
    - Sets it as the global version

6. **`enable-touchid-sudo-macos.sh`** (Standalone, macOS only)
    - Can be run at any time
    - Enables Touch ID for sudo authentication
    - Creates `/etc/pam.d/sudo_local` configuration

### Quick Setup Example

To set up a complete development environment, run:

```bash
cd ~/dotfiles-and-scripts/scripts

# 1. Install Homebrew
./brew-setup.sh

# 2. Install command-line tools (including asdf)
./brew-formulae-setup.sh

# 3. Install GUI applications
./brew-casks-setup.sh

# 4. Set up Node.js
./asdf-setup-node.sh

# 5. Set up Ruby
./asdf-setup-ruby.sh

# 6. Enable Touch ID for sudo (optional, macOS only)
./enable-touchid-sudo-macos.sh
```

**Note:** Make sure scripts are executable before running them:

```bash
chmod +x scripts/*.sh
```

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
