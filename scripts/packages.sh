for file in "$ISOLATED_DIR/PACKAGES"/*.sh; do
  [[ -f "$file" ]] && [[ "$file" != ".gitkeep" ]] && pacman -S --needed - <$file
done
