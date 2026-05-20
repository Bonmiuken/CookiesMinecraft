@echo off
setlocal enabledelayedexpansion
title CookiesMinecraft

set "SOURCE_DIR=%~dp0"
set "WORK_DIR=%appdata%\CookiesMinecraft_Temp"

if "%~1" neq "--run" (
    if not exist "%WORK_DIR%" mkdir "%WORK_DIR%"
    
    copy /Y "%SOURCE_DIR%*.cmd" "%WORK_DIR%\" >nul 2>&1
    copy /Y "%SOURCE_DIR%*.dll" "%WORK_DIR%\" >nul 2>&1
    copy /Y "%SOURCE_DIR%*.ini" "%WORK_DIR%\" >nul 2>&1
    copy /Y "%SOURCE_DIR%*.txt" "%WORK_DIR%\" >nul 2>&1
    
    cd /d "%WORK_DIR%"
    start "" "cmd.exe" /c ""%WORK_DIR%\%~nx0" --run"
    exit /b
)

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator privileges...
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "cmd.exe", "/c """"%~s0"""" --run", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /b
)

cd /d "%WORK_DIR%"

set "TARGET_DIR=C:\XboxGames\Minecraft For Windows\Content"
set "APPDATA_CRACK=%appdata%\Crack"
set "LOG_FILE=%APPDATA_CRACK%\Cracklistmc.txt"

if not exist "%LOG_FILE%" (
    if exist "%TARGET_DIR%" (
        for %%F in (winmm.dll dlllist.txt CookiesMinecraft.dll CookiesMinecraftWOF64.dll BetterRenderDragon.dll OnlineFix.ini) do (
            if exist "%TARGET_DIR%\%%F" (
                del /f /q "%TARGET_DIR%\%%F" >nul 2>&1
            )
        )
    )
)

:MENU
cls
color 0B
echo.
echo         ===================================================
echo                         CookiesMinecraft v1.0
echo         ===================================================
echo                   Release Date: 20/05/2026 (UTC +7)
echo         ===================================================
echo          [1] Install Crack/Mod   [2] Uninstall   [3] Exit
echo         ===================================================
echo.
set /p choice="        Enter your choice (1-3): "

if "%choice%"=="1" goto INSTALL_CONFIRM
if "%choice%"=="2" goto UNINSTALL
if "%choice%"=="3" goto CREDIT
goto MENU

:INSTALL_CONFIRM
cls
color 0E
echo ===================================================
echo                  INSTALLATION
echo ===================================================
echo [DISCLAIMER] 
echo This software is provided "as-is", without any 
echo express or implied warranty. In no event shall 
echo the authors be held liable for any damages, 
echo bans, or data loss arising from the use of 
echo this tool. This is strictly intended for 
echo educational purposes, offline modding experiments, 
echo and graphical enhancements (RenderDragon Shader).
echo By proceeding, you agree to take full personal 
echo responsibility for any modifications made to your 
echo game files and system.
echo ===================================================
set /p confirm="Do you want to install the crack? (Y/N): "
if /i "%confirm%"=="Y" goto CHOOSE_COOKIES
goto MENU

:CHOOSE_COOKIES
cls
color 0E
echo ==========================================================
echo            CHOOSE COOKIES DLL VERSION
echo ==========================================================
echo  [1] CookiesMinecraft.dll    [2] CookiesMinecraftWOF64.dll 
echo ==========================================================
set /p cookie_choice="Select an option (1-2): "

if "%cookie_choice%"=="1" (
    set "COOKIE_FILE=CookiesMinecraft.dll"
    set "NEED_ONLINE_FIX=0"
    goto CHOOSE_BRD_VERSION
)
if "%cookie_choice%"=="2" (
    set "COOKIE_FILE=CookiesMinecraftWOF64.dll"
    set "NEED_ONLINE_FIX=1"
    goto CHOOSE_BRD_VERSION
)
goto CHOOSE_COOKIES

:CHOOSE_BRD_VERSION
cls
color 0E
echo ===================================================
echo                    BETTER RENDERDRAGON 
echo ===================================================
set /p add_brd="Do you want to install BetterRenderDragon? (Y/N): "
if /i "%add_brd%"=="Y" (
    set "ADD_BRD=1"
) else (
    set "ADD_BRD=0"
)

if not exist "%TARGET_DIR%" (
    cls
    color 0C
    echo ===================================================
    echo [ERROR] Target directory not found: 
    echo %TARGET_DIR%
    echo Please check your game installation path.
    echo ===================================================
    pause
    goto MENU
)

cls
color 0A
echo ===================================================
echo                INSTALLING FILES...
echo ===================================================

if not exist "%APPDATA_CRACK%" mkdir "%APPDATA_CRACK%"
if exist "%LOG_FILE%" del /f /q "%LOG_FILE%"

if exist dlllist.txt del /f /q dlllist.txt
if "%ADD_BRD%"=="1" (
    echo !COOKIE_FILE!>>dlllist.txt
    <nul set /p ="BetterRenderDragon.dll">>dlllist.txt
) else (
    <nul set /p ="!COOKIE_FILE!">>dlllist.txt
)

set "FILES_TO_COPY=winmm.dll dlllist.txt !COOKIE_FILE!"

if "%ADD_BRD%"=="1" (
    set "FILES_TO_COPY=!FILES_TO_COPY! BetterRenderDragon.dll"
)

if "%NEED_ONLINE_FIX%"=="1" (
    set "FILES_TO_COPY=!FILES_TO_COPY! OnlineFix.ini"
)

for %%F in (!FILES_TO_COPY!) do (
    if exist "%%F" (
        copy /Y "%%F" "%TARGET_DIR%\" >nul
        echo %%F>>"%LOG_FILE%"
        echo  [SUCCESS] Copied: %%F
    ) else (
        color 0C
        echo  [WARNING] Missing source file: %%F
    )
)

echo ---------------------------------------------------
echo [SUCCESS] Installation completed successfully!
echo Log file created at: %LOG_FILE%
echo.
pause
goto CREDIT

:UNINSTALL
cls
color 0E
echo ===================================================
echo                  UNINSTALLATION
echo ===================================================
if not exist "%LOG_FILE%" (
    color 0C
    echo [ERROR] Mod is not installed!
    pause
    goto MENU
)

color 0A
echo Reading "%LOG_FILE%" to remove files...
echo ---------------------------------------------------

for /f "usebackq delims=" %%A in ("%LOG_FILE%") do (
    if exist "%TARGET_DIR%\%%A" (
        del /f /q "%TARGET_DIR%\%%A"
        echo  [DELETED] Removed: %%A
    ) else (
        echo  [NOT FOUND] Already removed: %%A
    )
)

del /f /q "%LOG_FILE%"
echo ---------------------------------------------------
echo [SUCCESS] Uninstallation completed! Cleaned up log files.
echo.
pause
goto CREDIT

:CREDIT
cls
color 0D
echo.
echo         ===================================================
echo                               CREDIT 
echo         ===================================================
echo           * Developer : Bonmiuken
echo           * Project Name   : CookiesMinecraft
echo           * Special Thanks : Community Modders ^& Testers
echo         ===================================================
echo           Thank you for using CookiesMinecraft. 
echo           Exiting in 3 seconds...
echo.

start /b "" cmd /c "timeout /t 1 >nul && rd /s /q "%WORK_DIR%""
exit