@echo off
:: Change to script directory
cd /d "%~dp0"

:: Skip the header function initially
goto main

:: ===== SEPARATOR FUNCTION =====
:get_terminal_width
:: Get terminal width using powershell
for /f "delims=" %%A in ('powershell -nologo -command "[console]::WindowWidth"') do set "termwidth=%%A"
:: Adjust width for rendering bug
set /a termwidth-=1
goto :eof

:separator
call :get_terminal_width
setlocal enabledelayedexpansion
set "line=="
set "full="
for /l %%i in (1,1,%termwidth%) do set "full=!full!!line!"
echo !full!
endlocal
goto :eof

:: ===== HEADER FUNCTION =====
:header
call :separator
echo     Make-Windows-Gr8-Again
call :separator
echo.
goto :eof

:: ===== MAIN LOGIC =====
:main
:: Check for admin rights
NET SESSION >nul 2>&1
if %ERRORLEVEL% neq 0 (
    call :header
    echo Run As Administrator!
    timeout /t 3 >nul
    exit /b
)

:: Display menu
:menu
call :header
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo 1. Run Make-Windows-Gr8-Again
echo.
echo 2. Install Requirements
echo.
echo.
echo.
echo.
echo.
echo.
echo.
call :separator
set /p "choice=Selection; Run Program = 1, Install Requirements = 2, Exit Program = X: "

:: Process user input
if "%choice%"=="1" (
    echo Launching launcher.ps1...
    timeout /t 1 >nul
    pwsh -ExecutionPolicy Bypass -File "launcher.ps1"
    goto exit_sequence
)
if "%choice%"=="2" (
    echo Launching installer.ps1...
    timeout /t 1 >nul
    pwsh -ExecutionPolicy Bypass -File "installer.ps1"
    goto exit_sequence
)
if /i "%choice%"=="X" (
    goto exit_sequence
)

:: Invalid input handler
echo Invalid selection! Please try again.
timeout /t 2 >nul
goto menu

:: ===== CLEAN EXIT =====
:exit_sequence
echo Make-Windows-Gr8-Again Exited.
timeout /t 1 >nul
echo Exiting batch in 5 Seconds...
timeout /t 5 >nul
exit /b
