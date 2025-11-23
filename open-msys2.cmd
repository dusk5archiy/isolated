@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%
set /p MSYS2_DIR=<%CWD%\env\MSYS2_DIR.txt

%MSYS2_DIR%\usr\bin\bash -l