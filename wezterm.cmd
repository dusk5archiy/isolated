@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%
set /p MSYS2_DIR=<%CWD%\SETUP\MSYS2_DIR.txt

set WEZTERM_CONFIG_FILE=%CWD%\wezterm\.wezterm.lua
set APP_PATH=%MSYS2_DIR%\ucrt64\bin\wezterm-gui.exe

start "" %APP_PATH%
