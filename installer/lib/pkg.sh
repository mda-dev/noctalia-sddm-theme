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

install_package() {
  case "$PKG_MANAGER" in
  apt)
    run_cmd sudo apt install -y "$1"
    ;;
  dnf)
    run_cmd sudo dnf install -y "$1"
    ;;
  yum)
    run_cmd sudo yum install -y "$1"
    ;;
  pacman)
    run_cmd sudo pacman -Sy --noconfirm "$1"
    ;;
  esac
}
