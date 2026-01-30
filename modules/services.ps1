Write-Info "Applying safe service tweaks..."

$services = @(
    "DiagTrack",            # Telemetry
    "MapsBroker",           # Offline maps
    "RetailDemo",           # Demo mode
    "RemoteRegistry",       # Security risk
    "Fax",
    "WSearch"               # Windows Search (safe to disable for gaming rigs)
)

foreach ($svc in $services) {
    Write-Info "Disabling service: $svc"
    Get-Service -Name $svc -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled
}

Write-Success "Service optimizations completed!"

