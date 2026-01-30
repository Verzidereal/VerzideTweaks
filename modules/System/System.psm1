# ================================================
#  SYSTEM MODULE - FULL AGGRESSIVE TWEAKS
# ================================================

function Optimize-Services {
    Write-Host "[System] Disabling heavy Windows services..." -ForegroundColor Cyan

    $services = @(
        "DiagTrack",            # Telemetry
        "SysMain",              # Superfetch
        "WSearch",              # Indexing
        "MapsBroker",
        "XblGameSave",
        "XboxNetApiSvc",
        "WbioSrvc",
        "RemoteRegistry",
        "RetailDemo",
        "Fax",
        "WerSvc",
        "WpnService"            # Push Notifications
    )

    foreach ($svc in $services) {
        try {
            Stop-Service -Name $svc -ErrorAction SilentlyContinue
            Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
            Write-Host " [+] Disabled: $svc"
        } catch {
            Write-Host " [!] Failed: $svc"
        }
    }
}

function Disable-Telemetry {
    Write-Host "[System] Removing telemetry system-wide..." -ForegroundColor Cyan

    $paths = @(
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    )

    foreach ($key in $paths) {
        New-Item -Path $key -Force | Out-Null
    }

    Set-ItemProperty -Path $paths[0] -Name AllowTelemetry -Value 0 -Type DWord
    Set-ItemProperty -Path $paths[1] -Name Enabled -Value 0 -Type DWord

    schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable | Out-Null
    schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable | Out-Null
}

function Set-HPET {
    Write-Host "[System] Disabling HPET + Dynamic Tick..." -ForegroundColor Cyan
    cmd.exe /c "bcdedit /deletevalue useplatformclock" 2>$null
    cmd.exe /c "bcdedit /set useplatformclock false" 2>$null
    cmd.exe /c "bcdedit /set disabledynamictick yes" 2>$null
}

function Optimize-SystemLatency {
    Write-Host "[System] Kernel & scheduler latency tweaks..." -ForegroundColor Cyan

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 1 /f | Out-Null
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f | Out-Null
}

function Set-UltimatePerformancePlan {
    Write-Host "[System] Setting & activating REAL Ultimate Performance plan..." -ForegroundColor Cyan

    $guidOutput = powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
    $guid = ($guidOutput | Select-String -Pattern "[0-9a-fA-F-]{36}").Matches.Value

    powercfg -setactive $guid
}

function Cleanup-System {
    Write-Host "[System] Deep cleaning OS garbage..." -ForegroundColor Cyan

    Start-Process "cmd.exe" -ArgumentList "/c rd /s /q %temp%" -WindowStyle Hidden
    Start-Process "cmd.exe" -ArgumentList "/c del /s /f /q C:\Windows\Temp\*" -WindowStyle Hidden
}

function Start-SystemTweaks {
    Write-Host "`n=========== SYSTEM OPTIMIZATION ===========" -ForegroundColor Cyan

    Optimize-Services
    Disable-Telemetry
    Optimize-SystemLatency
    Set-HPET
    Set-UltimatePerformancePlan
    Cleanup-System

    Write-Host "`n[✔] System tweaks applied successfully!" -ForegroundColor Green
}

Export-ModuleMember -Function *
