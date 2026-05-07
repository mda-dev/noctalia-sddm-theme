#!/usr/bin/env bash

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

run_cmd() {
  if [[ "${DRY_RUN:-false}" == true ]]; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

ask_yes_no() {
  local prompt="$1"
  while true; do
    read -rp "$prompt [y/n]: " yn
    case "$yn" in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "Please answer y or n." ;;
    esac
  done
}

option_exists() {
  local value="$1"
  shift
  local arr=("$@")

  for item in "${arr[@]}"; do
    if [[ "$item" == "$value" ]]; then
      return 0 # Found
    fi
  done
  return 1 # Not found
}

set_sddm_config() {
  local theme_conf="$SDDM_CONF_DIR/$PROJECT_NAME.conf"

  if [[ -f "$theme_conf" ]]; then
    SDDM_CONF="$theme_conf"
  elif [[ -f "$SDDM_CONF" ]]; then
    SDDM_CONF="$SDDM_CONF"
  else
    SDDM_CONF="$theme_conf"
  fi
}

find_current_sddm_theme() {
  local conf
  local current=""

  if [[ -f /etc/sddm.conf ]]; then
    current=$(ini_get /etc/sddm.conf Theme Current)
  fi

  if [[ -z "$current" && -d /etc/sddm.conf.d ]]; then
    for conf in /etc/sddm.conf.d/*.conf; do
      [[ -f "$conf" ]] || continue
      current=$(ini_get "$conf" Theme Current)
      [[ -n "$current" ]] && break
    done
  fi

  printf '%s\n' "$current"
}

sddm_greeter_cmd() {
  if command_exists sddm-greeter-qt6; then
    echo sddm-greeter-qt6
  elif command_exists sddm-greeter; then
    echo sddm-greeter
  else
    return 1
  fi
}

render_header() {
  local value="$1"
  echo ""
  echo "=================================================="
  echo "$1"
  echo "=================================================="
  echo ""
}

render_subheader() {
  local value="$1"
  echo ""
  echo "$1"
  echo ""
}

render_info() {
  local value="$1"
  echo "[ℹ️]: $1"
}
