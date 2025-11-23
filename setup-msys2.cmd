@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%
set /p MSYS2_DIR=<%CWD%\env\MSYS2_DIR.txt
set /p HOME=<%CWD%\env\HOME.txt

echo export W_ISOLATED_DIR="%CWD%" > %MSYS2_DIR%\etc\bash.bashrc
echo export ISOLATED_DIR=$(/usr/bin/cygpath "%CWD%") >>%MSYS2_DIR%\etc\bash.bashrc
echo source $ISOLATED_DIR/msys2/bash.bashrc >>%MSYS2_DIR%\etc\bash.bashrc

echo export ISOLATED_DIR=$(/usr/bin/cygpath "%CWD%") > %MSYS2_DIR%\etc\profile
echo export HOME=$(/usr/bin/cygpath "%HOME%") >>%MSYS2_DIR%\etc\profile
echo source $ISOLATED_DIR/msys2/profile >>%MSYS2_DIR%\etc\profile