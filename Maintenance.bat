@echo off
title System Maintenance & Cleanup
echo ========================================================
echo Running Advanced System Cleanup...
echo ========================================================

:: 1. Clear User Temp Files (Silent)
del /q /s /f "%temp%\*" 2>nul
for /d %%i in ("%temp%\*") do rd /s /q "%%i" 2>nul

:: 2. Clear System Temp Files (Silent)
del /q /s /f "C:\Windows\Temp\*" 2>nul
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" 2>nul

:: 3. Clear Windows Update Cache (Silent)
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
rd /s /q "%windir%\SoftwareDistribution\Download" 2>nul
del /q /s /f "%windir%\SoftwareDistribution\DataStore\*" 2>nul
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

:: 4. Run Advanced Disk Cleanup (Automated)
cleanmgr /sagerun:65535

:: 5. Prune Component Store (Safe baseline update)
echo Cleaning Component Store... 
dism /online /cleanup-image /startcomponentcleanup

:: 6. Flush DNS
ipconfig /flushdns >nul

echo ========================================================
echo Maintenance Complete! Your system is optimized.
echo ========================================================
pause