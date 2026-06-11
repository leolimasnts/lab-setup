#!/usr/bin/env bash
set -euo pipefail

require() {
  command -v "$1" >/dev/null 2>&1
}

ask() {
  local ans

  read -rp "$1 [Y/n]: " ans </dev/tty

  case "${ans,,}" in
  "" | y | yes | s | sim)
    return 0
    ;;
  *)
    return 1
    ;;
  esac

}

setup_vim() {

  require curl || {
    echo "Skipping Vim: missing curl" >&2
    return
  }

  echo "  Setting up Vim Config"

  local tmp
  tmp=$(mktemp)

  curl -fsSL "https://raw.githubusercontent.com/leolimasnts/lab-setup/main/.vimrc" -o "$tmp"

  if [ -f "$HOME/.vimrc" ]; then
    local backup
    backup="$HOME/.vimrc.bak-$(date +%Y%m%d-%H%M%S)"
    mv "$HOME/.vimrc" "$backup"

    echo "  Backed up existing .vimrc"
  fi

  mv "$tmp" "$HOME/.vimrc"

  echo "  Vim Config installed"
}

setup_font() {

  require tar || {
    echo "Skipping Fonts: missing tar" >&2
    return
  }
  require fc-cache || {
    echo "Skipping Fonts: missing fc-cache" >&2
    return
  }
  require curl || {
    echo "Skipping Fonts: missing curl" >&2
    return
  }

  echo "  Installing fonts..."

  mkdir -p "$HOME/.local/share/fonts"

  curl -fsSL "https://github.com/leolimasnts/lab-setup/archive/refs/heads/main.tar.gz" |
    tar -xz --strip-components=2 -C "$HOME/.local/share/fonts/" "lab-setup-main/fonts/"

  fc-cache -f >/dev/null

  echo "  Fonts installed"
}

setup_keyboard() {

  [ -n "${DISPLAY:-}" ] || {
    echo "Skipping keyboard remap: No X11 Display detected"
    return
  }
  require setxkbmap || {
    echo "Skipping keyboard remap: missing setxkbmap" >&2
    return
  }

  echo "  Remapping CapsLock to Esc..."

  setxkbmap -option
  setxkbmap -option caps:escape

  echo "  CapsLock remapped to Esc"
}

main() {
  echo "Initializing Setup..."

  ask "Install Vim config?" && setup_vim
  ask "Remap CapsLock to Esc?" && setup_keyboard
  ask "Install Fonts?" && setup_font

  echo "Done"
}

main
