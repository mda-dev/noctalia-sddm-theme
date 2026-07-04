#!/usr/bin/env bash

render_header "🧩 Installing Noctalia-Shell color sync..."

if ! has_target_user; then
  render_info "No non-root user detected (SUDO_USER unset); skipping color sync setup."
  return 0
fi

USER_HOME="$(user_home "$SUDO_USER")"
if [[ -z "$USER_HOME" ]]; then
  render_info "Could not resolve home directory for '$SUDO_USER'; skipping color sync setup."
  return 0
fi

USER_GROUP="$(id -gn "$SUDO_USER")"
CONFIG_DIR="$USER_HOME/.config/noctalia"
user_template="$CONFIG_DIR/user-templates.toml"

# Deploy the color template into the theme, and make the generated theme.conf
# writable so the shell (running as your user) can render into it.
run_cmd cp "$PROJECT_ROOT/theme.template.conf" "$DEST_DIR"
run_cmd chmod 666 "$DEST_DIR/theme.conf"

# Ensure the noctalia config dir + template file exist, owned by the user
# (creating them as root would lock Noctalia-Shell out of writing here).
run_cmd run_as_user mkdir -p "$CONFIG_DIR"
run_cmd run_as_user touch "$user_template"

# Register the sddm template (input -> output) for Noctalia-Shell to render.
run_cmd ini_set "$user_template" templates.sddm input_path "\"$DEST_DIR/theme.template.conf\""
run_cmd ini_set "$user_template" templates.sddm output_path "\"$DEST_DIR/theme.conf\""

# ini_set rewrites via a root-owned temp file, so restore user ownership.
run_cmd chown -R "$SUDO_USER:$USER_GROUP" "$CONFIG_DIR"

render_info "Remember to activate user-templates in noctalia-shell and refresh your theme to update sddm!"
