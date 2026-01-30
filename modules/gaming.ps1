
Write-Info "Applying gaming optimizations..."

# --- Enable Hardware Accelerated GPU Scheduling (HAGS) ---
Write-Info "Enabling HAGS..."
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" `
    -Name "HwSchMode" -Value 2 -PropertyType DWord -Force

# --- Disable Fullscreen Optimizations ---
Write-Info "Disabling fullscreen optimizations..."
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_DXGIHonorFSEWindowsCompatible" -Value 1

# --- Game Bar off ---
Write-Info "Disabling Game Bar..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "ShowStartupPanel" -Value 0

# --- Disable HPET (but not uninstall) ---
Write-Info "Disabling HPET from Windows..."
bcdedit /deletevalue useplatformclock 2>$null

# --- GPU Max Performance ---
Write-Info "Boosting GPU scheduling..."
Set-ItemProperty -Path $gamesReg -Name "Scheduling Category" -Value "High"

Write-Success "Gaming optimizations applied!"
