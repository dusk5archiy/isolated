@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%

set MSYS2_DIR=C:\msys64
set /p "MSYS2_DIR=Enter MSYS2 Directory (Windows path, default: %MSYS2_DIR%): "

set HOME=/home
echo Enter Your New Home Directory (Cygwin path, default: /home)
echo (Examples: /c/home)
set /p "HOME=Type here: "

echo export ISOLATED_DIR=$(/usr/bin/cygpath "%CWD%") > %MSYS2_DIR%\etc\profile
echo export HOME=%HOME% >>%MSYS2_DIR%\etc\profile
echo source $ISOLATED_DIR/etc/profile >>%MSYS2_DIR%\etc\profile

echo Isolated MSYS2 set up successfully.
pause
