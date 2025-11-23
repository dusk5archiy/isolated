for file in "$ISOLATED_DIR/msys2-packages"/*.txt; do
  [[ -f "$file" ]] && pacman -S --needed - <$file
done
