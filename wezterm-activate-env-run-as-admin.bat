@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%
setx WEZTERM_CONFIG_FILE "%CWD%\wezterm\.wezterm.lua" /M
