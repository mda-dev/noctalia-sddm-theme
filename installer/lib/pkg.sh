#!/usr/bin/env bash

detect_package_manager() {
  if command_exists apt; then
    echo apt
  elif command_exists dnf; then
    echo dnf
  elif command_exists yum; then
    echo yum
  elif command_exists pacman; then
    echo pacman
  else
    echo unsupported
  fi
}

package_dependencies() {
  case "$PKG_MANAGER" in
  dnf | yum)
    printf '%s\n' \
      "pkg:sddm" \
      "pkg:sddm-wayland-generic" \
      "pkg:qt6-qt5compat" \
      "pkg:qt6-qtsvg"
    ;;
  pacman)
    printf '%s\n' \
      "pkg:sddm" \
      "pkg:qt6-5compat" \
      "pkg:qt6-svg"
    ;;
  apt)
    printf '%s\n' \
      "pkg:sddm" \
      "pkg:qml6-module-qt5compat-graphicaleffects" \
      "pkg:qml6-module-qtsvg"
    ;;
  esac
}

install_package() {
  local name="${1#*:}"
  case "$PKG_MANAGER" in
  apt)
    run_cmd sudo apt install -y "$name"
    ;;
  dnf)
    run_cmd sudo dnf install -y "$name"
    ;;
  yum)
    run_cmd sudo yum install -y "$name"
    ;;
  pacman)
    run_cmd sudo pacman -Sy --noconfirm "$name"
    ;;
  esac
}
