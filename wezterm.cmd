@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%
set W_HOME_DRIVE_LETTER=%~d0
set W_HOME_DRIVE_LETTER=%W_HOME_DRIVE_LETTER::=%

set /p MSYS2_DIR=<%CWD%\var\env\MSYS2_DIR
call set MSYS2_DIR=%MSYS2_DIR%

set WEZTERM_CONFIG_FILE=%CWD%\wezterm\.wezterm.lua
set APP_PATH=%MSYS2_DIR%\ucrt64\bin\wezterm-gui.exe

start "" %APP_PATH%
