
Write-Info "Applying privacy and telemetry reduction..."

# --- Disable telemetry level ---
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" `
    -Name "AllowTelemetry" -Value 0 -PropertyType DWord -Force

# --- Advertising ID ---
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" `
    -Name "Enabled" -Value 0

# --- Diagnostic services ---
Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue

Write-Success "Telemetry reduction applied!"
