#!/bin/bash

# Script to download, extract, and replace VS Code from a ZIP file on Windows
# Requires: Git Bash or WSL environment on Windows

# Configuration
VSCODE_ZIP_URL="https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-archive"
TEMP_DIR="$TMP/vscode_update"
INSTALL_DIR="$APPS_DIR/code"

# Create temporary directory
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Download the latest VS Code ZIP file
echo "Downloading VS Code ZIP file..."
curl -L -o vscode.zip "$VSCODE_ZIP_URL"

# Check if download failed
if [ ! -f "vscode.zip" ]; then
  echo "Error: Failed to download VS Code ZIP file."
  exit 1
fi

# Backup current installation (if exists)
if [ -d "$INSTALL_DIR" ]; then
  echo "Backing up current VS Code installation..."
  mkdir -p "$BACKUP_DIR"
  cp -r "$INSTALL_DIR" "$BACKUP_DIR"
  # Terminate running VS Code processes (optional)
  taskkill //f //im code.exe 2>/dev/null || true
  # Remove current installation
  rm -rf "$INSTALL_DIR"
fi

# Extract the ZIP file
echo "Extracting VS Code..."
unzip -q vscode.zip -d "$TEMP_DIR/extracted"

# Move extracted contents to installation directory
mv "$TEMP_DIR/extracted/" "$INSTALL_DIR"

# Cleanup temporary files
echo "Cleaning up..."
rm -rf "$TEMP_DIR"

echo 'addpath $APPS_DIR/code/bin' >$ISOLATED_DIR/PATH/code.sh

echo "VS Code has been updated successfully."

