#!/usr/bin/env bash
source "$ROOT_DIR/lib/deps.sh"

DEPENDENCIES=(
  "cmd:sddm"
  "cmd:awk"
  "cmd:sddm-greeter-qt6"
  "pkg:qt6-5compat"
  "pkg:qt6-declarative"
)

echo
render_header "📦 Checking dependencies..."

if [[ "$PKG_MANAGER" == "unsupported" ]]; then
  echo "❌ Unsupported package manager"
  echo "Please manually install the required dependacies."
  exit 1
fi

MISSING=()

for dep in "${DEPENDENCIES[@]}"; do
  if is_installed "$dep"; then
    echo "✅ ${dep#*:} installed"
  else
    echo "❌ ${dep#*:} missing"
    MISSING+=("$dep")
  fi
done

if [[ ${#MISSING[@]} -eq 0 ]]; then
  echo
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
