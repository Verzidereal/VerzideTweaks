# VerzideTweaks - Main Launcher
# Loads modules and allows applying presets

Write-Host ""
Write-Host "==============================="
Write-Host "     Verzide Tweaks v1.0       "
Write-Host "==============================="
Write-Host ""

# Load all tweak modules
Import-Module "$PSScriptRoot/modules/System/System.psd1"
Import-Module "$PSScriptRoot/modules/Network/Network.psd1"
Import-Module "$PSScriptRoot/modules/Gaming/Gaming.psd1"
Import-Module "$PSScriptRoot/modules/Security/Security.psd1"

Write-Host "[+] Modules loaded successfully."
Write-Host ""

# Menu
Write-Host "Choose an option:"
Write-Host "1) Apply Balanced Preset"
Write-Host "2) Apply MaxFPS Preset"
Write-Host "3) Apply LowLatency Preset"
Write-Host "4) Run Individual Tweaks"
Write-Host "0) Exit"
Write-Host ""

$choice = Read-Host "Select a number"

switch ($choice) {
    "1" { . "$PSScriptRoot/presets/Balanced.ps1" }
    "2" { . "$PSScriptRoot/presets/MaxFPS.ps1" }
    "3" { . "$PSScriptRoot/presets/LowLatency.ps1" }
    "4" { . "$PSScriptRoot/tools/ManualTweaks.ps1" }
    "0" { exit }
    default { Write-Host "Invalid option." }
}
