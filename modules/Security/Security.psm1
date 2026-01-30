function Apply-PrivacyTweaks {
    Write-Host "[+] Applying privacy-safe tweaks..."

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
}

function Remove-MalwareApps {
    Write-Host "[+] Removing known malicious OEM apps..."

    $junk = @(
        "WildTangent",
        "McAfee",
        "Norton",
        "CandyCrush",
        "Booking",
        "HPJumpStart"
    )

    foreach ($app in $junk) {
        Get-AppxPackage *$app* -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
        Write-Host " ✓ Removed: $app"
    }
}

function Apply-FirewallGamingPreset {
    Write-Host "[+] Applying firewall gaming preset..."

    netsh advfirewall set allprofiles state on
    netsh advfirewall firewall add rule name="Gaming UDP Allow" dir=in action=allow protocol=UDP localport=1024-65535
}

function Enable-WindowsDefender {
    Write-Host "[+] Ensuring Windows Defender is enabled..."

    Set-MpPreference -DisableRealtimeMonitoring $false
}

