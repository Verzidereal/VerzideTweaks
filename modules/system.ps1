Write-Info "Applying system performance optimizations..."

# CPU Scheduler tweaks
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" `
    -Name "SystemResponsiveness" -Value 0 -PropertyType DWord -Force

# GPU Priority
$reg = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
Set-ItemProperty -Path $reg -Name "GPU Priority" -Value 8
Set-ItemProperty -Path $reg -Name "Priority" -Value 6

# Network throttling
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" `
    -Name "NetworkThrottlingIndex" -Value 0xffffffff -PropertyType DWord -Force

Write-Success "System optimization applied!"

