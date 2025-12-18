#!/usr/bin/env zsh

# Only run in interactive shells
[[ $- != *i* ]] && return

# --- Get user's first name (portable) ---
if command -v getent >/dev/null 2>&1; then
  FULL_NAME="$(getent passwd "$USER" | cut -d ':' -f 5 | cut -d ',' -f 1)"
else
  FULL_NAME="$(id -F 2>/dev/null)"
fi

FIRST_NAME="${FULL_NAME%% *}"
FIRST_NAME="${FIRST_NAME:-$USER}"

USER_NAME="$USER"
HOST_NAME="$(hostname -s)"
LOGIN_TIME="$(date +"%I:%M %p")"

# --- Uptime ---
if command -v uptime >/dev/null 2>&1; then
  UPTIME_RAW="$(uptime | sed 's/.*up \([^,]*\),.*/\1/')"
  UPTIME="Uptime: ${UPTIME_RAW}"
else
  UPTIME=""
fi

# --- Avengers quotes ---
AVENGERS_QUOTES=(
  "I am Iron Man."
  "Avengers… Assemble!"
  "I can do this all day."
  "We have a Hulk."
  "I am inevitable."
  "Dormammu, I've come to bargain."
  "Genius, billionaire, playboy, philanthropist."
)

RANDOM_QUOTE="${AVENGERS_QUOTES[RANDOM % ${#AVENGERS_QUOTES[@]} + 1]}"

# --- Cowsay (optional dependency) ---
if command -v cowsay >/dev/null 2>&1; then
  cowsay -f dragon "$RANDOM_QUOTE"
fi

# --- Welcome message ---
echo
echo "Welcome, ${FIRST_NAME} 👋"
echo
echo "You started your session as ${USER_NAME} on ${HOST_NAME}"
echo "Login time: ${LOGIN_TIME}"
[[ -n "$UPTIME" ]] && echo "$UPTIME"
echo
