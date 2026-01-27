#!/usr/bin/env bash

echo
render_header "✅ Installation complete!"

if ask_yes_no "Would you like to test your current theme?"; then
  run_cmd sudo -u $SUDO_USER sddm-greeter --test-mode --theme $DEST_DIR
else
  echo "Goodbye cruel world!"
fi
