@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%

set MSYS2_DIR=C:\msys64
set /p "MSYS2_DIR=Enter MSYS2 Directory (Windows path, default: %MSYS2_DIR%): "

set WEZTERM_CONFIG_FILE=%CWD%\wezterm\.wezterm.lua
set APP_PATH=%MSYS2_DIR%\ucrt64\bin\wezterm-gui.exe

start "" %APP_PATH%
