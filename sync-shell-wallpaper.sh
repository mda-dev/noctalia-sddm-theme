#!/bin/bash

THEME_NAME="noctalia"
DEST_DIR="/usr/share/sddm/themes/$THEME_NAME/Assets"
JSON_FILE="$HOME/.cache/noctalia/wallpapers.json"

# wait for wallpaper entry to be changed in json file before reading
sleep 2

WALLPAPER=$(jq -r '
    if (.wallpapers | length) > 0 then
        (.wallpapers | to_entries[0].value) as $value
        | if ($value | type) == "object" then
            ($value.dark // $value.light)
          else
            $value
          end
    else
        .defaultWallpaper
    end
' "$JSON_FILE")

if [[ -z "$WALLPAPER" || "$WALLPAPER" == "null" ]]; then
  echo "No wallpaper found in config"
  exit 1
fi

EXT="${WALLPAPER##*.}"

cp -fa "$WALLPAPER" "$DEST_DIR/background.png"
