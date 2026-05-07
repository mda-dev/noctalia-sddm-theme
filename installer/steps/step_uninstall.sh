#!/usr/bin/env bash

render_header "🗑️ Uninstalling $PROJECT_NAME sddm theme!"

# Get sddm config file
run_cmd set_sddm_config
OLD_THEME=$(ini_get $SDDM_CONF Theme Current.bak)
if [[ -n "$OLD_THEME" ]]; then
  run_cmd ini_set $SDDM_CONF Theme Current $OLD_THEME
  run_cmd ini_del $SDDM_CONF Theme Current.bak
else
  run_cmd ini_del $SDDM_CONF Theme Current
  if [[ "$SDDM_CONF" == "$SDDM_CONF_DIR/$PROJECT_NAME.conf" ]]; then
    run_cmd rm -f "$SDDM_CONF"
  fi
fi

# remove theme folder
run_cmd rm -rf $DEST_DIR

# Deactivate color-sync
user_template="/home/$SUDO_USER/.config/noctalia/user-templates.toml"
run_cmd ini_remove_section $user_template templates.sddm
run_cmd chown $SUDO_USER $user_template

render_subheader "✅ Theme removed successfuly"
echo "[NOTE]: Please manually remove the Noctalia-Shell wallpaper hook if previously installed!"

exit 1
