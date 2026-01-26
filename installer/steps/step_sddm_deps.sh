#!/usr/bin/env bash
source "$ROOT_DIR/lib/deps.sh"

DEPENDENCIES=(
  "cmd:sddm"
  "cmd:sddm-greeter"
  "pkg:qt5-quickcontrols2"
  "pkg:qt5-graphicaleffects"
)

PKG_MANAGER=$(detect_package_manager)

if [[ "$PKG_MANAGER" == "unsupported" ]]; then
  echo "❌ Unsupported package manager"
  exit 1
fi

echo "📦 Checking dependencies..."
echo

MISSING=()

for dep in "${DEPENDENCIES[@]}"; do
  if is_installed "$dep"; then
    echo "✅ ${dep#*:} installed"
  else
    echo "❌ ${dep#*:} missing"
    MISSING+=("$dep")
  fi
done

echo

if [[ ${#MISSING[@]} -eq 0 ]]; then
  echo "🎉 All dependencies satisfied"
  return 0
fi

echo "The following dependencies are missing:"
printf "  - %s\n" "${MISSING[@]}"
echo

if ask_yes_no "Install missing dependencies?"; then
  for dep in "${MISSING[@]}"; do
    echo "⬇️ Installing $dep..."
    install_package "$dep"
  done
else
  echo "⚠️ Cannot continue without dependencies"
  exit 1
fi
