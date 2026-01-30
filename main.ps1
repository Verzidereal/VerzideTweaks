Import-Module "$PSScriptRoot\utils.ps1" -Force

function Show-Menu {
    Clear-Host
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "       Windows FPS Optimizer" -ForegroundColor Green
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1) Optimize System"
    Write-Host "2) Gaming Tweaks"
    Write-Host "3) Network Tweaks"
    Write-Host "4) Service Tweaks"
    Write-Host "5) Telemetry / Privacy"
    Write-Host "6) Restore Defaults"
    Write-Host "0) Exit"
    Write-Host ""
}

while ($true) {
    Show-Menu
    $option = Read-Host "Select an option"

    switch ($option) {
        1 { . "$PSScriptRoot\modules\system.ps1" }
        2 { . "$PSScriptRoot\modules\gaming.ps1" }
        3 { . "$PSScriptRoot\modules\network.ps1" }
        4 { . "$PSScriptRoot\modules\services.ps1" }
        5 { . "$PSScriptRoot\modules\telemetry.ps1" }
        6 { . "$PSScriptRoot\modules\restore.ps1" }
        0 { exit }
        default { Write-Host "Invalid option." -ForegroundColor Red }
    }

    pause
}

