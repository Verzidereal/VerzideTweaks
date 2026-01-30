Write-Host "[Low-Latency Preset] Reducing latency..." -ForegroundColor Yellow

Import-Module "$PSScriptRoot\..\Modules\Performance.psm1"
Import-Module "$PSScriptRoot\..\Modules\Network.psm1"
Import-Module "$PSScriptRoot\..\Modules\Gaming.psm1"

# CPU/GPU low-latency
Apply-TimerResolution
Apply-GPURenderTweaks
Enable-GameMode
Disable-XboxOverlays

# Network optimizations
Apply-NetworkLowLatency
Apply-DNSGaming
Disable-PowerSavingNetwork

# System
Set-ProcessorScheduling Gaming
Disable-BackgroundServices
Optimize-RegistryLowLatency

Write-Host "✓ Low-latency preset applied." -ForegroundColor Green
