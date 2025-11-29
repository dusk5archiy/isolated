for file in "$ISOLATED_DIR/env"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$CUSTOM_SETTINGS_DIR/env"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$ISOLATED_DIR/init"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$CUSTOM_SETTINGS_DIR/init"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

CUSTOM_PATH="$CUSTOM_SETTINGS_DIR/scripts:$ISOLATED_DIR/scripts"

addpath() {
  local dir="$1"
  CUSTOM_PATH="$CUSTOM_PATH:$dir"
}

for file in "$ISOLATED_DIR/path"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$CUSTOM_SETTINGS_DIR/path"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

export PATH="$CUSTOM_PATH:$PATH"

unset addpath
unset CUSTOM_PATH
