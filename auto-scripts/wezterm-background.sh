SRC_DIR="/$SYSTEM_DRIVE_LETTER/Users/$(/usr/bin/whoami)/AppData/Local/Packages/Microsoft.BingWallpaper_8wekyb3d8bbwe/LocalState/images/bing"
if [ -d "$SRC_DIR" ]; then
  DEST_DIR="$ISOLATED_DIR/wezterm/background"
  FILE=$(ls "$SRC_DIR"/*.jpg | sort | tail -n 1)
  cp "$FILE" "$DEST_DIR/desktop.jpg"
fi