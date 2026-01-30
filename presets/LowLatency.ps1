Write-Host "[MAX FPS PRESET] Applying extreme tweaks..." -ForegroundColor Red

Import-Module "$PSScriptRoot\..\Modules\Performance.psm1"
Import-Module "$PSScriptRoot\..\Modules\Network.psm1"
Import-Module "$PSScriptRoot\..\Modules\Gaming.psm1"
Import-Module "$PSScriptRoot\..\Modules\Security.psm1"

# System performance max
Enable-UltimatePerformance
Disable-BackgroundServices
Optimize-RegistryAggressive
Disable-Animations
Disable-VisualEffects

# GPU + Rendering
Apply-GPURenderTweaks
Apply-TimerResolution
Force-HighPerformanceGPU

# Network performance max
Apply-NetworkTournamentMode
Apply-DNSGaming
Disable-PowerSavingNetwork
Apply-TCPGamingMode

# Gaming
Apply-FullGamingPreset
Optimize-GameProcesses

# Security (safe but lightened)
Disable-DefenderNonCritical
Optimize-FirewallGaming

Write-Host "✓ MAX FPS preset applied." -ForegroundColor Green
