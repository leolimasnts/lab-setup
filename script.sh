#!/usr/bin/env bash
set -euo pipefail

ask_to_execute() {
  local msg="$1"
  local ans_raw=""

  read -p "$msg [Y/n]:" ans_raw

  if [ -z "$ans_raw" ]; then
    ans_raw="y"
  fi

  local ans="${ans_raw,,}"

  case "$ans" in
  y | s | yes | sim)
    return 0
    ;;
  *)
    return 1
    ;;
  esac

}

setup_vim() {
  true
}

setup_font() {
  echo "    Downloading Maple Mono fonts..."

  # creating directory
  local dir="$HOME/.local/share/fonts"
  mkdir -p dir

}

setup_keyboard() {
  echo "    Remapping CapsLock to Esc..."
  xmodmap -e "clear Lock"
  setxkbmap -option caps:escape
  echo "    Keyboard remapped successfully!"
}

main() {
  echo "Initializing Setup..."

  if ask_to_execute "Setup Vim config?"; then
    setup_vim
  fi

  if ask_to_execute "Remap CapsLock to Esc?"; then
    setup_caps
  fi

  if ask_to_execute "Add Maple Mono to system?"; then
    setup_keyboard
  fi

  echo "Finishing Setup..."
}
