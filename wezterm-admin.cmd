@echo off
set APP_PATH=.\wezterm.cmd

powershell -Command "Start-Process -FilePath '%APP_PATH%' -Verb RunAs"
