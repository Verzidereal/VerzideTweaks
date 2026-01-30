Write-Host "[Preset] Applying LowLatency preset..."

Set-HPET
Optimize-TCP
Disable-Nagle
Optimize-NetworkAdapter
Reduce-InputLag
Apply-FirewallGamingPreset

Write-Host "[LowLatency] Done!"

