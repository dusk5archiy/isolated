for file in "$ISOLATED_DIR/PACKAGES"/*.sh; do
  [[ -f "$file" ]] && pacman -S --needed - <$file
done
