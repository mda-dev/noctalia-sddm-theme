#!/usr/bin/env bash
set -e

if [[ "$EUID" -ne 0 ]]; then
  echo "🔐 Script requires elevated privileges..."
  exec sudo "$0" "$@"
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$ROOT_DIR/.." && pwd)"
PROJECT_NAME=noctalia

DEST_DIR="/usr/share/sddm/themes/$PROJECT_NAME"
SDDM_CONF="/etc/sddm.conf"
SDDM_CONF_DIR="/etc/sddm.conf.d"

DRY_RUN=false

options=("base")

for arg in "$@"; do
  case "$arg" in
  --dry-run | -n)
    DRY_RUN=true
    ;;
  *) ;;
  esac
done

export DRY_RUN

source "$ROOT_DIR/lib/utils.sh"
source "$ROOT_DIR/lib/pkg.sh"
source "$ROOT_DIR/lib/awk/awk-crud.sh"

echo
render_header "🚀 $PROJECT_NAME sddm theme instalation"

if $DRY_RUN; then
  render_info "DRY-RUN MODE ENABLED (no changes will be made)"
fi

PKG_MANAGER=$(detect_package_manager)

render_subheader "🎨 Checking for previous installation..."

if [ -d "$DEST_DIR" ]; then
  if ask_yes_no "The theme $PROJECT_NAME is already installed. Do you wish to remove it?"; then
    echo ""
    source "$ROOT_DIR/steps/step_uninstall.sh"
  else
    echo "Nothing more to do here... Bye bye"
    exit 1
  fi
fi

source "$ROOT_DIR/steps/step_features.sh"
source "$ROOT_DIR/steps/step_sddm_deps.sh"
source "$ROOT_DIR/steps/step_install_base.sh"

if option_exists "colors" ${options[@]}; then
  source "$ROOT_DIR/steps/step_install_color.sh"
fi

if option_exists "wallpaper" ${options[@]}; then
  source "$ROOT_DIR/steps/step_install_wallpaper.sh"
fi

source "$ROOT_DIR/steps/step_finish.sh"
