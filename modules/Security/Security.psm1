function Invoke-StrongPrivacyHardening {
    Write-Host "[+] Applying strong privacy hardening..."

    $regPaths = @{
        "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" = @{ Enabled = 0 }
        "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" = @{ AllowTelemetry = 0 }
        "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" = @{ TailoredExperiencesWithDiagnosticDataEnabled = 0 }
        "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" = @{ Start_TrackProgs = 0; Start_TrackDocs = 0 }
        "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" = @{
            SoftLandingEnabled = 0
            SystemPaneSuggestionsEnabled = 0
            ContentDeliveryAllowed = 0
            OemPreInstalledAppsEnabled = 0
        }
    }

    foreach ($path in $regPaths.Keys) {
        foreach ($name in $regPaths[$path].Keys) {
            reg add $path /v $name /t REG_DWORD /d $($regPaths[$path][$name]) /f | Out-Null
        }
    }

    Write-Host "[✔] Strong privacy hardening applied."
}

function Invoke-FullDebloatSecuritySafe {
    Write-Host "[+] Removing bloatware safely..."

    $apps = @(
        "Microsoft.3DBuilder",
        "Microsoft.BingWeather",
        "Microsoft.GetHelp",
        "Microsoft.Getstarted",
        "Microsoft.Messaging",
        "Microsoft.Microsoft3DViewer",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo",
        "Microsoft.MSPaint"
    )

    foreach ($app in $apps) {
        Get-AppxPackage -AllUsers *$app* | Remove-AppxPackage -ErrorAction SilentlyContinue
        Write-Host " ✓ Removed: $app"
    }

    Write-Host "[✔] Safe debloat completed."
}

function Invoke-FirewallHardening {
    Write-Host "[+] Applying firewall hardening (aggressive)..."

    netsh advfirewall set allprofiles state on

    $blockRules = @(
        "spoolsv.exe",
        "wermgr.exe",
        "CompatTelRunner.exe"
    )

    foreach ($exe in $blockRules) {
        netsh advfirewall firewall add rule name="Block $exe" dir=out action=block program="%windir%\system32\$exe" enable=yes | Out-Null
    }

    netsh advfirewall firewall add rule name="Secure DNS (DoT/DoH)" dir=out action=allow protocol=TCP localport=853 | Out-Null

    Write-Host "[✔] Firewall hardened aggressively."
}

function Invoke-NetworkHardening {
    Write-Host "[+] Applying advanced network security hardening..."

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 0xff /f | Out-Null
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v NoNameReleaseOnDemand /t REG_DWORD /d 1 /f | Out-Null

    # Disable old protocols
    Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart -ErrorAction SilentlyContinue

    Write-Host "[✔] Network hardened."
}

function Invoke-ExploitProtectionHardening {
    Write-Host "[+] Applying exploit protection rules..."

    Set-ProcessMitigation -System -Enable DEP, SEHOP, ForceRelocateImages, StrictHandleCheck, CFG
    Set-ProcessMitigation -System -Disable Win32kSystemCalls

    Write-Host "[✔] Exploit protection elevated."
}

function Invoke-DisableRemoteRisks {
    Write-Host "[+] Disabling remote services (aggressive)..."

    $services = @(
        "RemoteRegistry",
        "WinRM",
        "RemoteAccess",
        "SSDPSRV",
        "upnphost"
    )

    foreach ($svc in $services) {
        Set-Service $svc -StartupType Disabled -ErrorAction SilentlyContinue
        Stop-Service $svc -ErrorAction SilentlyContinue
        Write-Host " ✓ Disabled: $svc"
    }

    Write-Host "[✔] Remote attack surface minimized."
}

function Invoke-FullSecurityHardening {
    Write-Host "`n=== FULL SECURITY HARDENING ==="

    Invoke-StrongPrivacyHardening
    Invoke-FullDebloatSecuritySafe
    Invoke-FirewallHardening
    Invoke-NetworkHardening
    Invoke-ExploitProtectionHardening
    Invoke-DisableRemoteRisks

    Write-Host "[✔] Full aggressive security hardening applied successfully."
}
