# VerzideTweaks Installer

Write-Host "Installing VerzideTweaks..."

# Unblock all scripts
Get-ChildItem -Recurse *.ps1 | Unblock-File
Get-ChildItem -Recurse *.psm1 | Unblock-File

Write-Host "Scripts unblocked."
Write-Host "You can now run:  powershell -ExecutionPolicy Bypass -File main.ps1"
