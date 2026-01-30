Write-Host "[Balanced Preset] Applying balanced performance tweaks..." -ForegroundColor Cyan

Import-Module "$PSScriptRoot\..\Modules\Performance.psm1"
Import-Module "$PSScriptRoot\..\Modules\Network.psm1"
Import-Module "$PSScriptRoot\..\Modules\Gaming.psm1"

# Performance
Enable-UltimatePerformance
Optimize-Services -Safe
Optimize-Registry

# Network
Apply-NetworkBalanced
Apply-DNSOptimizations

# Gaming
Enable-GameMode
Disable-XboxOverlays

Write-Host "✓ Balanced preset applied." -ForegroundColor Green
