#!/usr/bin/env bash
source "$ROOT_DIR/lib/deps.sh"

DEPENDENCIES=(
  "cmd:awk"
  "cmd_any:sddm-greeter-qt6,sddm-greeter"
)
mapfile -t PACKAGE_DEPENDENCIES < <(package_dependencies)
DEPENDENCIES+=("${PACKAGE_DEPENDENCIES[@]}")

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
    if [[ "$dep" != pkg:* ]]; then
      echo "⚠️ ${dep#*:} must be installed manually"
      continue
    fi
    echo "⬇️ Installing $dep..."
    install_package "$dep"
  done
else
  echo "⚠️ Cannot continue without dependencies"
  exit 1
fi
