@echo off
set CWD=%~dp0
set CWD=%CWD:~0,-1%
set W_HOME_DRIVE_LETTER=%~d0
set W_HOME_DRIVE_LETTER=%W_HOME_DRIVE_LETTER::=%
set HOME_DRIVE_LETTER=%W_HOME_DRIVE_LETTER%

for %%L in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
    call set "HOME_DRIVE_LETTER=%%HOME_DRIVE_LETTER:%%L=%%L%%"
)

echo ISOLATED ENVIRONMENT SETUP

echo.

echo Available placeholders:
echo.
echo %%CWD%%
echo The current directory
echo This variable is set to: %CWD%
echo.
echo %%W_HOME_DRIVE_LETTER%%
echo Uppercase label of the drive containing the current directory
echo This variable is set to: %W_HOME_DRIVE_LETTER%
echo.
echo %%HOME_DRIVE_LETTER%% %HOME_DRIVE_LETTER%
echo Lowercase label of the drive containing the current directory
echo This variable is set to: %HOME_DRIVE_LETTER%

echo.

set MSYS2_DIR=C:\msys64
echo Enter MSYS2 Directory (Windows path, default: %MSYS2_DIR%)
echo (Examples: C:\msys64, %%W_HOME_DRIVE_LETTER%%:\msys64)
set /p "MSYS2_DIR=MSYS2_DIR: "
echo %MSYS2_DIR%> %CWD%\var\env\MSYS2_DIR

echo.

set CUSTOM_SETTINGS_DIR=C:\custom_settings
echo Enter MSYS2 Directory (Windows path, default: %CUSTOM_SETTINGS_DIR%)
echo (Examples: C:\custom_settings, %%W_HOME_DRIVE_LETTER%%:\custom_settings)
set /p "CUSTOM_SETTINGS_DIR=CUSTOM_SETTINGS_DIR: "
echo %CUSTOM_SETTINGS_DIR%> %CWD%\var\env\CUSTOM_SETTINGS_DIR

echo.

set HOME=/home
echo Enter Your New Home Directory (Cygwin path, default: /home)
echo (Examples: /home, /c/home, /%%HOME_DRIVE_LETTER%%/home)
set /p "HOME=HOME: "
echo %HOME%> %CWD%\var\env\HOME

echo.

echo Isolated MSYS2 set up successfully.
pause

