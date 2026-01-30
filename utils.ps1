function Write-Info ($msg) { Write-Host "[*] $msg" -ForegroundColor Cyan }
function Write-Success ($msg) { Write-Host "[+] $msg" -ForegroundColor Green }
function Write-WarningMsg ($msg) { Write-Host "[!] $msg" -ForegroundColor Yellow }
function Write-ErrorMsg ($msg) { Write-Host "[X] $msg" -ForegroundColor Red }

