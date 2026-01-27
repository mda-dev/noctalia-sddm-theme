#!/usr/bin/env bash

# TODO: automatically add the sync script to noctalia configs

render_subheader "🔄 Installing Noctalia-Shell wallpaper sync..."

run_cmd cp "$PROJECT_ROOT/sync-shell-wallpaper.sh" $DEST_DIR

echo "[INFO]: Add following script to noctalia hooks and chenge your wallpaper after"
echo "[INFO]: $DEST_DIR/sync-shell-wallpaper.sh"
