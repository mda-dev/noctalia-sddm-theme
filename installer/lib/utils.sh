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

# Resolve a user's home directory from the passwd database (robust against
# non-standard home locations). Defaults to the invoking (sudo) user.
user_home() {
  local u="${1:-$SUDO_USER}"
  [[ -n "$u" ]] || return 1
  getent passwd "$u" | cut -d: -f6
}

# True when we have a real non-root invoking user to act on behalf of.
has_target_user() {
  [[ -n "$SUDO_USER" && "$SUDO_USER" != "root" ]]
}

# Run a command as the invoking (non-root) user, preserving correct ownership
# for anything created under their home directory.
run_as_user() {
  if has_target_user; then
    sudo -u "$SUDO_USER" "$@"
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
  # Get sddm config file
  if [[ ! -f $SDDM_CONF ]]; then
    echo "Select your sddm config file"
    cd $SDDM_CONF_DIR
    select file in *; do
      if [[ -f "$file" ]]; then
        SDDM_CONF="$SDDM_CONF_DIR/$file"
        break
      else
        echo "Invalid choice"
      fi
    done
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
