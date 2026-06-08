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
  echo "    Setting up Vim Config"
  curl -fsSl "https://raw.githubusercontent.com/leolimasnts/lab-setup/main/.vimrc" -o "$HOME/.vimrc"
  echo "    Vim Config setted up successfully!"
}

setup_font() {
  echo "    Downloading fonts..."

  local tmp_dir
  tmp_dir=$(mktemp -d)

  trap 'rm -rf "$tmp_dir"' EXIT

  mkdir -p "$HOME/.local/share/fonts"

  git clone "https://github.com/leolimasnts/lab-setup" "$tmp_dir"
  cp "$tmp_dir" "$HOME/.local/share/fonts"
  rm -rf /tmp/lab-setup

  fc-cache -f -v

  rm -rf "$tmp_dir"
  trap - EXIT
  echo "    Fonts installed successfully!"
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
    setup_keyboard
  fi

  if ask_to_execute "Install Maple Mono?"; then
    setup_font
  fi

  echo "The End..."
  read -p "Press any key to continue" </dev/tty
}

main
