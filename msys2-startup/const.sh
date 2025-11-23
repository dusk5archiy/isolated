mkdir -p "$HOME/AppData"

export APPDATA="$HOME/AppData/Roaming"
mkdir -p "$APPDATA"

export LOCALAPPDATA="$HOME/AppData/Local"
mkdir -p "$LOCALAPPDATA"
export XDG_CONFIG_HOME=$LOCALAPPDATA
export XDG_DATA_HOME=$LOCALAPPDATA

export XDG_CACHE_HOME="$HOME/.cache"
mkdir -p "$XDG_CACHE_HOME"

export XDG_STATE_HOME=$HOME/.local/state
mkdir -p "$XDG_STATE_HOME"

export TMP="$HOME/tmp"
export TEMP="$HOME/tmp"
mkdir -p "$TMP"

export USERPROFILE="$HOME/profile"
mkdir -p "$USERPROFILE"

mkdir -p $USERPROFILE/AppData/Roaming/yazi/state

export DESKTOP="$USERPROFILE/Desktop"
mkdir -p $DESKTOP

export APPS_DIR="$HOME/apps"
mkdir -p $APPS_DIR

export HOMEPATH=\\home