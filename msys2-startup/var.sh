for file in "$ISOLATED_DIR/msys2-env"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$ISOLATED_DIR/ENV"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$ISOLATED_DIR/msys2-init"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$ISOLATED_DIR/INIT"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

CUSTOM_PATH="$ISOLATED_DIR/scripts"

addpath() {
  local dir="$1"
  CUSTOM_PATH="$CUSTOM_PATH:$dir"
}

for file in "$ISOLATED_DIR/msys2-path"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$ISOLATED_DIR/PATH"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

export PATH="$CUSTOM_PATH:$PATH"

unset addpath
unset CUSTOM_PATH

for file in "$ISOLATED_DIR/auto-scripts"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done
