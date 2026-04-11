#!/usr/bin/env bash

render_header "✅ Installation complete!"

if ask_yes_no "Would you like to test your current theme?"; then
  run_cmd sudo -u $SUDO_USER sddm-greeter-qt6 --test-mode --theme $DEST_DIR
fi

render_subheader "Goodbye cruel world!"
