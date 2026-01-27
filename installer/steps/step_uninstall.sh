#!/usr/bin/env bash

render_header "🗑️ Uninstalling $PROJECT_NAME sddm theme!"

# Get sddm config file
run_cmd set_sddm_config
OLD_THEME=$(ini_get $SDDM_CONF Theme Current.bak)
run_cmd ini_set $SDDM_CONF Theme Current $OLD_THEME
run_cmd ini_del $SDDM_CONF Theme Current.bak

# remove theme folder
run_cmd rm -rf $DEST_DIR

# Deactivate color-sync
user_template="/home/$SUDO_USER/.config/noctalia/user-templates.toml"
run_cmd ini_remove_section $user_template templates.sddm
run_cmd chown $SUDO_USER $user_template

render_subheader "✅ Theme removed successfylly"
echo "[NOTE]: Please manually remove the Noctalia-Shell wallpaper hook if previously installed!"

exit 1
