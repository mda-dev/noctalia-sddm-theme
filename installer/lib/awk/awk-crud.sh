#!/usr/bin/env bash

_ini_tmp() {
  mktemp "${TMPDIR:-/tmp}/ini.XXXXXX"
}

ini_get() {
  local file=$1 section=$2 key=$3

  awk -v section="$section" -v key="$key" '
    BEGIN { FS="="; in_section=0 }

    /^\[.*\]$/ {
      curr=$0
      gsub(/[\[\]]/, "", curr)
      in_section = (curr == section)
    }

    in_section && $0 !~ /^[[:space:]]*[#;]/ {
      k=$1
      gsub(/[[:space:]]*/, "", k)
      if (k == key) {
        sub(/^[^=]+= */, "", $0)
        print
        exit
      }
    }
  ' "$file"
}

ini_set() {
  local file=$1 section=$2 key=$3 value=$4
  local tmp=$(_ini_tmp)

  awk -v section="$section" -v key="$key" -v value="$value" '
    BEGIN { FS="="; in_section=0; seen_section=0; done=0 }

    /^\[.*\]$/ {
      if (in_section && !done) {
        print key "=" value
        done=1
      }
      curr=$0
      gsub(/[\[\]]/, "", curr)
      in_section = (curr == section)
      if (in_section) seen_section=1
    }

    in_section && $0 !~ /^[[:space:]]*[#;]/ {
      k=$1
      gsub(/[[:space:]]*/, "", k)
      if (k == key) {
        print key "=" value
        done=1
        next
      }
    }

    { print }

    END {
      if (!seen_section) {
        print ""
        print "[" section "]"
        print key "=" value
      } else if (in_section && !done) {
        print key "=" value
      }
    }
  ' "$file" >"$tmp" && mv "$tmp" "$file"
}

ini_del() {
  local file=$1 section=$2 key=$3
  local tmp=$(_ini_tmp)

  awk -v section="$section" -v key="$key" '
  BEGIN { FS="="; in_section=0 }
    /^\[.*\]$/ {
      curr=$0
      gsub(/[\[\]]/, "", curr)
      in_section = (curr == section)
    }
    in_section && $0 !~ /^[[:space:]]*[#;]/ {
      k=$1
      gsub(/[[:space:]]*/, "", k)
      if (k == key) next
    }
    { print }
  ' "$file" >"$tmp" && mv "$tmp" "$file"
}

ini_create_section() {
  local file=$1 section=$2
  local tmp=$(_ini_tmp)

  awk -v section="$section" '
    BEGIN { found=0 }
    /^\[.*\]$/ {
      curr=$0
      gsub(/[\[\]]/, "", curr)
      if (curr == section) found=1
    }
    { print }
    END {
      if (!found) {
        print ""
        print "[" section "]"
      }
    }
  ' "$file" >"$tmp" && mv "$tmp" "$file"
}

ini_remove_section() {
  local file=$1 section=$2
  local tmp=$(_ini_tmp)
  awk -v section="$section" '
    BEGIN { skip=0 }
    /^\[.*\]/ {
      skip = ($0 == "[" section "]")
    }
    !skip
  ' "$file" >"$tmp" && mv "$tmp" "$file"
}
