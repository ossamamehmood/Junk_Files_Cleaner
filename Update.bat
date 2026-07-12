echo ==== SYSTEM FILE CHECK ====
sfc /scannow

echo ==== DISM CHECK HEALTH ====
DISM /Online /Cleanup-Image /CheckHealth

echo ==== DISM SCAN HEALTH ====
DISM /Online /Cleanup-Image /ScanHealth

echo ==== DISM RESTORE HEALTH ====
DISM /Online /Cleanup-Image /RestoreHealth

echo ==== STOPPING WINDOWS UPDATE SERVICES ====
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver

echo ==== RESETTING WINDOWS UPDATE CACHE ====
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old

echo ==== STARTING WINDOWS UPDATE SERVICES ====
net start wuauserv
net start cryptSvc
net start bits
net start msiserver

echo ==== FORCING WINDOWS UPDATE SCAN ====
UsoClient StartScan
UsoClient StartDownload
UsoClient StartInstall

echo ==== UPDATING ALL APPS (WINGET) ====
winget upgrade --all

echo ==== ALL TASKS COMPLETED ====
pause