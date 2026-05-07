#!/usr/bin/env bash

SDDM_CONF="/etc/sddm.conf"
render_header "📂 Installing theme files..."

# Create theme dir
run_cmd mkdir $DEST_DIR

#copy over SDDM theme files and scripts
run_cmd cp -ra "$PROJECT_ROOT/Assets" $DEST_DIR
run_cmd cp -r "$PROJECT_ROOT/Components" $DEST_DIR
run_cmd cp "$PROJECT_ROOT/Main.qml" $DEST_DIR
run_cmd cp "$PROJECT_ROOT/Globals.qml" $DEST_DIR
run_cmd cp "$PROJECT_ROOT/qmldir" $DEST_DIR
run_cmd cp "$PROJECT_ROOT/metadata.desktop" $DEST_DIR
run_cmd cp "$PROJECT_ROOT/theme.conf" $DEST_DIR
render_info "Theme files copied successfuly!"

render_subheader "⚙️ Activating theme..."

if [[ ! -f "$SDDM_CONF" ]]; then
  run_cmd mkdir -p "$SDDM_CONF_DIR"
  SDDM_CONF="$SDDM_CONF_DIR/$PROJECT_NAME.conf"
fi
run_cmd touch "$SDDM_CONF"

# Set theme to noctalia
CUR_THEME=$(find_current_sddm_theme)
if [[ -n "$CUR_THEME" && "$CUR_THEME" != "$PROJECT_NAME" ]]; then
  run_cmd ini_set "$SDDM_CONF" Theme Current.bak "$CUR_THEME"
fi
run_cmd ini_set "$SDDM_CONF" Theme Current "$PROJECT_NAME"
render_info "Theme activated!"
