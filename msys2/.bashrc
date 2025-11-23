export SYSTEM_DRIVE_LETTER=$(echo $SYSTEMDRIVE | /usr/bin/cut -c1 | /usr/bin/tr '[:upper:]' '[:lower:]')
export HOME_DRIVE_LETTER=$(/usr/bin/cygpath -w / | /usr/bin/cut -c1 | /usr/bin/tr '[:upper:]' '[:lower:]')

for file in "$ISOLATED_DIR/msys2-startup"/*.sh; do
  [[ -f "$file" ]] && source "$file"
done

current_dir="$(pwd)"
if [[ $current_dir == "/" || $current_dir == $ISOLATED_DIR || $current_dir == "/$SYSTEM_DRIVE_LETTER/Users/$(/usr/bin/whoami)" ]]; then
  cd "/$SYSTEM_DRIVE_LETTER/Users/$(/usr/bin/whoami)/Desktop"
fi