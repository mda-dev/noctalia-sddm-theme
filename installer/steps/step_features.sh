render_subheader "📋 Select instalation features:"

echo "1. Install base sddm theme"

if ! command -v qs >/dev/null 2>&1; then
  echo "[INFO]: QuickShell is not installed cant use color and wallpaper sync!"
  return 0
fi

if ask_yes_no "2. Install Noctalia-Shell color sync?"; then
  options+=("colors")

fi
if ask_yes_no "3. Install Noctalia-Shell wallpaper sync"; then
  options+=("wallpaper")
fi
