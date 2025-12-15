# ---- Custom Functions ----

# asdf required functions
if command -v asdf >/dev/null; then
  listNodeVersions() {
    if [ -n "$1" ]; then
      asdf list all nodejs | grep -i "$1"
    else
      asdf list all nodejs
    fi
  }
fi

listInstalledNodeVersions() {
  if ! command -v asdf >/dev/null; then
    echo "asdf not installed"
    return 1
  fi
  echo "Installed Node.js versions:"
  asdf list nodejs
}


# git
## function git-branch - used in theme.zsh
parse_git_branch() {
    # check if git is installed
    if ! command -v git >/dev/null 2>&1; then
        return 
    fi

    # check if we are in a git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        return
    fi

    # print current branch name
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    echo "[$branch] "
}


## native development functions
## functions for open deeplink using uri scheme
## https://reactnavigation.org/docs/deep-linking/
open-uri-android() {
  # check if npx is installed
  if ! command -v npx >/dev/null 2>&1; then
    echo "❌ ERROR: npx isn't installed or not part of the PATH"
    return 1
  fi

  # check for passed deeplink
  if [ -z "$1" ]; then
    echo "Usage: open-uri-android <deeplink>"
    return 1
  fi

  # open deeplink
  npx uri-scheme open "$1" --android
}

open-uri-ios() {
  # check if npx is installed
  if ! command -v npx >/dev/null 2>&1; then
    echo "❌ ERROR: npx isn't installed or not part of the PATH"
    return 1
  fi

  # check for passed deeplink
  if [ -z "$1" ]; then
    echo "Usage: open-uri-ios <deeplink>"
    return 1
  fi

  # open deeplink
  npx uri-scheme open "$1" --ios
}

open_url_in_ios_simulator() {
  # check if xcrun exists
  if ! command -v xcrun >/dev/null 2>&1; then
    echo "❌ Error: xcrun is not installed or not in PATH"
    return 1
  fi

  # check if a URL argument is provided
  if [ -z "$1" ]; then
    echo "Usage: open_ios_simulator <url>"
    echo "Example: open_ios_simulator myapp://home"
    return 1
  fi

  # attempt to open the URL in the booted simulator
  if ! xcrun simctl openurl booted "$1"; then
    echo "❌ Failed to open URL in iOS simulator"
    return 1
  fi

  echo "✅ URL opened in iOS simulator: $1"
}
