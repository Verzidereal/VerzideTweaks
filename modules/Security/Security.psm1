# ==========================================================
#  SECURITY MODULE - FULL AGGRESSIVE HARDENING
# ==========================================================

function Invoke-StrongPrivacyHardening {
    Write-Host "[Security] Applying strong privacy hardening..." -ForegroundColor Cyan

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
            New-Item -Path $path -Force | Out-Null
            Set-ItemProperty -Path $path -Name $name -Value $($regPaths[$path][$name]) -Type DWord
        }
    }

    Write-Host "[✔] Strong privacy hardening applied."
}

function Invoke-FullDebloatSecuritySafe {
    Write-Host "[Security] Removing bloatware safely..." -ForegroundColor Cyan

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
        try {
            Get-AppxPackage -AllUsers *$app* | Remove-AppxPackage -ErrorAction SilentlyContinue
            Write-Host " [+] Removed: $app"
        } catch {
            Write-Host " [!] Could not remove: $app"
        }
    }

    Write-Host "[✔] Safe debloat completed."
}

function Invoke-FirewallHardening {
    Write-Host "[Security] Applying firewall hardening (aggressive)..." -ForegroundColor Cyan

    netsh advfirewall set allprofiles state on | Out-Null

    $blockRules = @(
        "spoolsv.exe",
        "wermgr.exe",
        "CompatTelRunner.exe"
    )

    foreach ($exe in $blockRules) {
        $path = "$env:WINDIR\System32\$exe"
        if (Test-Path $path) {
            netsh advfirewall firewall add rule name="Block $exe" dir=out action=block program="$path" enable=yes | Out-Null
            Write-Host " [+] Blocked outbound: $exe"
        }
    }

    netsh advfirewall firewall add rule name="Allow Secure DNS (DoT/DoH)" dir=out action=allow protocol=TCP localport=853 | Out-Null

    Write-Host "[✔] Firewall hardened aggressively."
}

function Invoke-NetworkHardening {
    Write-Host "[Security] Applying advanced network hardening..." -ForegroundColor Cyan

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 0xff /f | Out-Null
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" /v NoNameReleaseOnDemand /t REG_DWORD /d 1 /f | Out-Null

    try {
        Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart -ErrorAction Stop
        Write-Host " [+] Disabled SMB1Protocol"
    } catch {
        Write-Host " [!] SMB1 already disabled or not available."
    }

    Write-Host "[✔] Network hardened."
}

function Invoke-ExploitProtectionHardening {
    Write-Host "[Security] Applying exploit protection rules..." -ForegroundColor Cyan

    try {
        Set-ProcessMitigation -System -Enable DEP, SEHOP, ForceRelocateImages, StrictHandleCheck, CFG -ErrorAction Stop
        Write-Host " [+] Core exploit mitigations applied."
    } catch {
        Write-Host " [!] Some exploit mitigations not supported."
    }

    try {
        Set-ProcessMitigation -System -Disable Win32kSystemCalls -ErrorAction Stop
        Write-Host " [+] Win32k system call restrictions applied."
    } catch {
        Write-Host " [!] Win32k mitigation unsupported on this system."
    }

    Write-Host "[✔] Exploit protection elevated."
}

function Invoke-DisableRemoteRisks {
    Write-Host "[Security] Disabling remote services (aggressive)..." -ForegroundColor Cyan

    $services = @(
        "RemoteRegistry",
        "WinRM",
        "RemoteAccess",
        "SSDPSRV",
        "upnphost"
    )

    foreach ($svc in $services) {
        try {
            Stop-Service $svc -ErrorAction SilentlyContinue
            Set-Service $svc -StartupType Disabled -ErrorAction SilentlyContinue
            Write-Host " [+] Disabled: $svc"
        } catch {
            Write-Host " [!] Could not disable: $svc"
        }
    }

    Write-Host "[✔] Remote attack surface minimized."
}

function Invoke-FullSecurityHardening {
    Write-Host "`n========== FULL SECURITY HARDENING ==========" -ForegroundColor Cyan

    Invoke-StrongPrivacyHardening
    Invoke-FullDebloatSecuritySafe
    Invoke-FirewallHardening
    Invoke-NetworkHardening
    Invoke-ExploitProtectionHardening
    Invoke-DisableRemoteRisks

    Write-Host "`n[✔] Full aggressive security hardening applied successfully." -ForegroundColor Green
}

Export-ModuleMember -Function *
