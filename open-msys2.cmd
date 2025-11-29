@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%
set W_HOME_DRIVE_LETTER=%~d0
set W_HOME_DRIVE_LETTER=%W_HOME_DRIVE_LETTER::=%

set HOME_DRIVE_LETTER=%W_HOME_DRIVE_LETTER%

for %%L in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
    call set "HOME_DRIVE_LETTER=%%HOME_DRIVE_LETTER:%%L=%%L%%"
)

set /p MSYS2_DIR=<%CWD%\var\env\MSYS2_DIR
call set MSYS2_DIR=%MSYS2_DIR%

set /p CUSTOM_SETTINGS_DIR=<%CWD%\var\env\CUSTOM_SETTINGS_DIR
call set CUSTOM_SETTINGS_DIR=%CUSTOM_SETTINGS_DIR%

set /p HOME=<%CWD%\var\env\HOME
call set HOME=%HOME%

set "PROFILE_FILE=%MSYS2_DIR%\etc\profile"

echo export ISOLATED_DIR=$(/usr/bin/cygpath "%CWD%") > %PROFILE_FILE%
echo export CUSTOM_SETTINGS_DIR=$(/usr/bin/cygpath "%CUSTOM_SETTINGS_DIR%") >>%PROFILE_FILE%
echo export HOME=%HOME% >>%PROFILE_FILE%
echo source $ISOLATED_DIR/etc/profile >>%PROFILE_FILE%


%MSYS2_DIR%\usr\bin\bash -l
