#!/usr/bin/env bash

SDDM_CONF="/etc/sddm.conf"

echo
echo "================================="
echo "📂 Installing theme files..."
echo "================================="

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

echo
echo "⚙️ Activating theme..."
