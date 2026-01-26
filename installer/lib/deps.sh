#!/usr/bin/env bash

is_installed_cmd() {
  command -v "$1" >/dev/null 2>&1
}

is_installed_pkg() {
  case "$PKG_MANAGER" in
  apt) dpkg -s "$1" >/dev/null 2>&1 ;;
  dnf | yum) rpm -q "$1" >/dev/null 2>&1 ;;
  pacman) pacman -Qi "$1" >/dev/null 2>&1 ;;
  esac
}

is_installed() {
  local type="${1%%:*}"
  local name="${1#*:}"

  case "$type" in
  cmd) is_installed_cmd "$name" ;;
  pkg) is_installed_pkg "$name" ;;
  *)
    echo "Unknown dependency type: $type"
    return 1
    ;;
  esac
}
