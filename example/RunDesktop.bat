@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApplication.bat

:desktop-run
echo.
echo Starting AIR Debug Launcher


if "%ARCHITECTURE%"=="64" adl64 "%APP_XML%" "%APP_DIR%" -extdir "%EXT_FOLDER_DIR%"
if "%ARCHITECTURE%"=="32" adl "%APP_XML%" "%APP_DIR%" -extdir "%EXT_FOLDER_DIR%"



if errorlevel 1 goto error
goto end

:error
pause

:end