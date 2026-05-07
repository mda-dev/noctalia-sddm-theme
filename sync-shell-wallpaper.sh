#!/bin/bash

THEME_NAME="noctalia"
DEST_DIR="/usr/share/sddm/themes/$THEME_NAME/Assets"
JSON_FILE="$HOME/.cache/noctalia/wallpapers.json"

# wait for wallpaper entry to be changed in json file before reading
sleep 2

WALLPAPER=$(jq -r '
    def valid_path:
        select(type == "string" and length > 0);

    def wallpaper_value:
        if type == "object" then
            (.dark // .light // empty) | valid_path
        else
            valid_path
        end;

    ((.wallpapers // {})
        | to_entries[]
        | .value
        | wallpaper_value) // (.defaultWallpaper | valid_path) // empty
' "$JSON_FILE")

if [[ -z "$WALLPAPER" || "$WALLPAPER" == "null" ]]; then
  echo "No wallpaper found in config"
  exit 1
fi

EXT="${WALLPAPER##*.}"

cp -fa "$WALLPAPER" "$DEST_DIR/background.png"
