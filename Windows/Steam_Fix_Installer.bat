@echo off
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

title Steam Fix v2 Installer - Intro
echo.
echo                                                READ ME.txt
echo.
echo ==========================================================================================================
echo "    _____        _____    
echo     / _ \ \      / / _ \   
echo "  | | | \ \ /\ / / | | | 
echo "  | |_| |\ V  V /| |_| |  
echo     \___/  \_/\_/  \___/   
echo   Organized Web Operations 
echo   YourBoyRory 
echo.
echo    SteamFix is a bash script writen by Rory and compiled with shc
echo    Here is some documentation for this horible program:
echo.
echo      steamfix [arguments]
echo.
echo.
echo      /h                Help.
echo      /n                Does not launch steam after killing it.
echo.
echo      /setlogin         Open GUI that stores username and password to pass it to steam on launch
echo                        Use only if steam constantly required re-auth such as when using a VPN
echo                        Uses aescrypt.exe (Included)
echo.
echo ==========================================================================================================
echo.
echo Press any key to start installer . . .
pause>nul
cls
title Steam Fix v2 Installer - Installing
echo.

SETLOCAL
FOR /F "usebackq" %%f IN (`PowerShell -NoProfile -Command "Write-Host([Environment]::GetFolderPath('Desktop'))"`) DO (
  SET "DESKTOP_FOLDER=%%f"
  )


mkdir "%ProgramFiles%\Steam Fix"
mkdir "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Steam Fix"

copy "%~dp0Steam_Fix_v3\" "%ProgramFiles%\Steam Fix\" || color c
copy "%~dp0Steam_Fix_v3\Steam Fix Login Set.lnk" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Steam Fix\" || color c
copy "%~dp0Steam_Fix_v3\Steam Fix Login Set.lnk" "%DESKTOP_FOLDER%"
copy "%~dp0Steam_Fix_v3\Steam Fix.lnk" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Steam Fix\" || color c
copy "%~dp0Steam_Fix_v3\Steam Fix.lnk" "%DESKTOP_FOLDER%"





echo.
title Steam Fix v2 Installer - Installation done
echo.
@pause