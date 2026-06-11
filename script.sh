#!/usr/bin/env bash
set -euo pipefail

check_dependencies() {
  echo "Checking dependencies..."
  local deps=(curl git)
  for cmd in "${deps[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Error: '$cmd" is required but not installed. Exiting.
      exist 1
    fi
  done
  echo "All dependencies avaliable! Running the script..."
}

ask_to_execute() {
  local msg="$1"
  local ans_raw=""

  read -p "$msg [Y/n]:" ans_raw </dev/tty

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

  if [ -f "$HOME/.vimrc" ]; then
    mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
    echo "    Backed up existing .vimrc to .vimrc.bak"
  fi

  echo "    Vim Config set up successfully!"
}

setup_font() {
  if ! command -v fc-cache $ >/dev/null; then
    echo "    Skipping fonts: fc-cache tool not found"
    return 0
  fi
  echo "    Downloading fonts..."

  local tmp_dir
  tmp_dir=$(mktemp -d)

  trap 'rm -rf "$tmp_dir"' EXIT

  mkdir -p "$HOME/.local/share/fonts"

  git clone --depth 1 "https://github.com/leolimasnts/lab-setup" "$tmp_dir"
  cp "$tmp_dir/fonts/"* "$HOME/.local/share/fonts"

  fc-cache -f -v
  echo "    Fonts installed successfully!"
}

setup_keyboard() {
  if [ -z "${DISPLAY:-}" ]; then
    echo "Skipping keyboard remap: No X11 Display detected"
    return 0
  fi
  echo "    Remapping CapsLock to Esc..."
  xmodmap -e "clear Lock"
  setxkbmap -option caps:escape
  echo "    Keyboard remapped successfully!"
  echo "    To revert, run: setxkbmap -option"
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
