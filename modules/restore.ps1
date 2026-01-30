
Write-Info "Restoring Windows default settings..."

# --- Restore HAGS ---
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" `
    -Name "HwSchMode" -Value 1

# --- Restore GameBar ---
Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1

# --- Enable HPET default ---
bcdedit /deletevalue useplatformclock 2>$null

# --- Restore network settings ---
Write-Info "Restoring network defaults..."
$net = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
Get-ChildItem $net | ForEach-Object {
    Remove-ItemProperty -Path $_.PsPath -Name "TcpNoDelay" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $_.PsPath -Name "TcpAckFrequency" -ErrorAction SilentlyContinue
}

Write-Success "System restored!"
