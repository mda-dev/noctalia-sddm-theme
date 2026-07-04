#!/usr/bin/env bash

render_header "🧩 Installing Noctalia-Shell wallpaper sync..."

if ! command -v jq >/dev/null 2>&1; then
  render_info "jq is required for wallpaper sync but was not found -- install it before using the hook."
fi

run_cmd cp "$PROJECT_ROOT/sync-shell-wallpaper.sh" "$DEST_DIR"
run_cmd chmod +x "$DEST_DIR/sync-shell-wallpaper.sh"

# The hook runs as your user and overwrites this file in place, so it must be
# writable by non-root. The sync script preserves this inode/permission.
run_cmd chmod 666 "$DEST_DIR/Assets/background.png"

render_info "Add the following script to noctalia hooks (Settings > Hooks > Wallpaper changed) and change your wallpaper after:"
echo "------------------------------------------------"
echo "$DEST_DIR/sync-shell-wallpaper.sh"
echo "------------------------------------------------"
