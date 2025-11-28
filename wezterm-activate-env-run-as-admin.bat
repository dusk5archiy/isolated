@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%
setx WEZTERM_CONFIG_FILE "%CWD%\wezterm\.wezterm.lua" /M

echo The system variable for Wezterm's configuration file has been set.
pause
