Write-Info "Applying network latency optimizations..."

# --- TCP-Nagle OFF (improves ping consistency) ---
Write-Info "Disabling Nagle Algorithm..."
$net = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"

Get-ChildItem $net | ForEach-Object {
    New-ItemProperty -Path $_.PsPath -Name "TcpNoDelay" -Value 1 -PropertyType DWord -Force
    New-ItemProperty -Path $_.PsPath -Name "TcpAckFrequency" -Value 1 -PropertyType DWord -Force
}

# --- TCP Global optimizations ---
Write-Info "Optimizing TCP global settings..."
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" `
    -Name "TcpDelAckTicks" -Value 0 -PropertyType DWord -Force

# --- DNS Cache Optimization ---
Write-Info "Optimizing DNS cache..."
ipconfig /flushdns

Write-Success "Network module applied!"

