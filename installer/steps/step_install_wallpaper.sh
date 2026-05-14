#!/usr/bin/env bash

# TODO: automatically add the sync script to noctalia configs
render_header "🧩 Installing Noctalia-Shell wallpaper sync..."

run_cmd cp "$PROJECT_ROOT/sync-shell-wallpaper.sh" $DEST_DIR

render_info "Add the following script to noctalia hooks and change your wallpaper after"
echo "------------------------------------------------"
echo "$DEST_DIR/sync-shell-wallpaper.sh"
echo "------------------------------------------------"
