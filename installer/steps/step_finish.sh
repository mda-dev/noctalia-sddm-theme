#!/usr/bin/env bash

render_header "✅ Installation complete!"

if ask_yes_no "Would you like to test your current theme?"; then
  GREETER_CMD=$(sddm_greeter_cmd)
  run_cmd sudo -u "$SUDO_USER" "$GREETER_CMD" --test-mode --theme "$DEST_DIR"
fi

render_subheader "Goodbye cruel world!"
