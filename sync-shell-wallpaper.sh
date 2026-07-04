#!/bin/bash
set -uo pipefail

THEME_NAME="noctalia"
DEST="/usr/share/sddm/themes/$THEME_NAME/Assets/background.png"
JSON_FILE="$HOME/.cache/noctalia/wallpapers.json"

if ! command -v jq >/dev/null 2>&1; then
  echo "sync-shell-wallpaper: jq is not installed" >&2
  exit 1
fi

# Wait for the wallpaper entry to be written to the json before reading it.
sleep 2

if [[ ! -r "$JSON_FILE" ]]; then
  echo "sync-shell-wallpaper: cannot read $JSON_FILE" >&2
  exit 1
fi

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
  echo "sync-shell-wallpaper: no wallpaper found in config" >&2
  exit 1
fi

if [[ ! -r "$WALLPAPER" ]]; then
  echo "sync-shell-wallpaper: wallpaper source not readable: $WALLPAPER" >&2
  exit 1
fi

if [[ ! -w "$DEST" ]]; then
  echo "sync-shell-wallpaper: $DEST is not writable." >&2
  echo "  Run: sudo chmod 666 '$DEST'" >&2
  exit 1
fi

# Write in place (via redirect) so the file keeps its existing inode and 0666
# permissions -- copying would need write access to the root-owned theme dir.
if cat "$WALLPAPER" >"$DEST"; then
  echo "sync-shell-wallpaper: updated background from $WALLPAPER"
else
  echo "sync-shell-wallpaper: failed to write $DEST" >&2
  exit 1
fi
