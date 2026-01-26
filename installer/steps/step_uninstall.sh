#!/usr/bin/env bash

echo "🎨 Checking for previous installation..."

if [[ -d "$DEST_DIR" ]]; then
  echo "[DEBUG: should uninstall]"
  return 0
fi
