#!/usr/bin/env bash

# TODO: activate noctalia user templates from config
user_template="/home/$SUDO_USER/.config/noctalia/user-templates.toml"

render_subheader "🔄 Installing Noctalia-Shell color sync..."

run_cmd cp "$PROJECT_ROOT/theme.template.conf" $DEST_DIR
run_cmd chmod 666 "$DEST_DIR/theme.conf"

run_cmd ini_set $user_template templates.sddm input_path "\"$DEST_DIR/theme.template.conf\""
run_cmd ini_set $user_template templates.sddm output_path "\"$DEST_DIR/theme.conf\""

run_cmd chown $SUDO_USER $user_template
echo "[INFO] Remember to activate user-templates in noctalia-shell and refresh your theme to update sddm!"
