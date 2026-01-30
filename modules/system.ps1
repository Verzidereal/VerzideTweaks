Write-Info "Applying core system performance optimizations..."

# --- CPU and Scheduler Tweaks ---
Write-Info "Optimizing CPU scheduler..."
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" `
    -Name "SystemResponsiveness" -Value 0 -PropertyType DWord -Force

# --- GPU Priorities ---
Write-Info "Setting GPU priority..."
$gamesReg = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
Set-ItemProperty -Path $gamesReg -Name "GPU Priority" -Value 8
Set-ItemProperty -Path $gamesReg -Name "Priority" -Value 6

# --- Network Throttling Fix ---
Write-Info "Disabling system network throttling..."
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" `
    -Name "NetworkThrottlingIndex" -Value 0xffffffff -PropertyType DWord -Force

# --- Timer accuracy (Precise system clock) ---
Write-Info "Enabling precise system timers..."
powercfg /setacvalueindex scheme_current sub_processor THROTTLING 0

Write-Success "System module applied successfully!"
