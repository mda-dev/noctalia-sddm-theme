#!/usr/bin/env bash
set -e

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$ROOT_DIR/.." && pwd)"
PROJECT_NAME=noctalia

DEST_DIR="/usr/share/sddm/themes/$PROJECT_NAME"

DRY_RUN=false

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

echo "========================================"
echo "🚀 Installing $PROJECT_NAME" sddm theme
echo "========================================"

if $DRY_RUN; then
  echo "🧪 DRY-RUN MODE ENABLED (no changes will be made)"
fi

echo
source "$ROOT_DIR/steps/step_uninstall.sh"
source "$ROOT_DIR/steps/step_sddm_deps.sh"
source "$ROOT_DIR/steps/step_install_base.sh"
source "$ROOT_DIR/steps/step_finish.sh"
