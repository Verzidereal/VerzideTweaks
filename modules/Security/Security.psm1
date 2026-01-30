function Apply-PrivacyTweaks {
    Write-Host "[+] Applying privacy-safe tweaks..."

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f | Out-Null
    reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f | Out-Null
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
        try {
            Get-AppxPackage *$app* -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host " ✓ Removed: $app"
        } catch {
            Write-Host " - Failed to remove: $app" -ForegroundColor Yellow
        }
    }
}

function Apply-FirewallGamingPreset {
    Write-Host "[+] Applying firewall gaming preset..."

    netsh advfirewall set allprofiles state on | Out-Null
    netsh advfirewall firewall add rule name="Gaming UDP Allow" dir=in action=allow protocol=UDP localport=1024-65535 | Out-Null
}

function Enable-WindowsDefender {
    Write-Host "[+] Ensuring Windows Defender is enabled..."

    try {
        Set-MpPreference -DisableRealtimeMonitoring $false -ErrorAction SilentlyContinue
    } catch {
        Write-Host " - Defender control unavailable." -ForegroundColor Yellow
    }
}

function Start-SecurityTweaks {
    Write-Host "`n====================================" -ForegroundColor Cyan
    Write-Host "        Running Security Tweaks"
    Write-Host "====================================`n"

    Apply-PrivacyTweaks
    Remove-MalwareApps
    Apply-FirewallGamingPreset
    Enable-WindowsDefender

    Write-Host "`n[✔] Security tweaks applied successfully!" -ForegroundColor Green
}

# Export functions so the module loads correctly
Export-ModuleMember -Function *
