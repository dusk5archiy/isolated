@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%

set MSYS2_DIR=C:\msys64
set /p "MSYS2_DIR=Enter MSYS2 Directory (Windows path, default: %MSYS2_DIR%): "

%MSYS2_DIR%\usr\bin\bash -l
