for file in "$ISOLATED_DIR/msys2-env"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$ISOLATED_DIR/custom-env"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$ISOLATED_DIR/msys2-init"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$ISOLATED_DIR/custom-init"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

CUSTOM_PATH="$ISOLATED_DIR/custom-scripts:$ISOLATED_DIR/msys2-scripts"

addpath() {
  local dir="$1"
  CUSTOM_PATH="$CUSTOM_PATH:$dir"
}

for file in "$ISOLATED_DIR/msys2-path"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

for file in "$ISOLATED_DIR/custom-path"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

export PATH="$CUSTOM_PATH:$PATH"

unset addpath
unset CUSTOM_PATH
