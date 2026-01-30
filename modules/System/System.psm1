function Optimize-Services {
    Write-Host "[+] Optimizing non-essential Windows services..."

    $services = @(
        "DiagTrack",        # Telemetry
        "SysMain",          # Superfetch
        "WSearch"           # Windows Search
    )

    foreach ($svc in $services) {
        if (Get-Service -Name $svc -ErrorAction SilentlyContinue) {
            Set-Service -Name $svc -StartupType Disabled
            Write-Host " ✓ Disabled service: $svc"
        }
    }
}

function Disable-Cortana {
    Write-Host "[+] Disabling Cortana..."

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f | Out-Null
}

function Disable-Bloatware {
    Write-Host "[+] Removing Microsoft bloatware..."

    $bloat = @(
        "Microsoft.3DBuilder",
        "Microsoft.XboxApp",
        "Microsoft.GetHelp",
        "Microsoft.Getstarted",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo"
    )

    foreach ($app in $bloat) {
        Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
        Write-Host " ✓ Removed: $app"
    }
}

function Cleanup-System {
    Write-Host "[+] Cleaning temporary files and Windows cache..."

    Cleanmgr /sagerun:1
    Start-Process "cmd.exe" "/c del /s /q %temp%\*" -WindowStyle Hidden
}

function Set-HPET {
    Write-Host "[+] Disabling HPET for lower latency..."

    bcdedit /deletevalue useplatformclock 2>$null
    bcdedit /set disabledynamictick yes
}

function Set-PowerPlan {
    Write-Host "[+] Setting Ultimate Performance power plan..."

    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>$null
    powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
}

function Start-SystemTweaks {
    Write-Host "`n====================================" -ForegroundColor Cyan
    Write-Host "      Running System Optimizations"
    Write-Host "====================================`n"

    Optimize-Services
    Disable-Cortana
    Disable-Bloatware
    Cleanup-System
    Set-HPET
    Set-PowerPlan

    Write-Host "`n[✔] System optimizations applied successfully!" -ForegroundColor Green
}

# EXPORT FUNCTIONS
Export-ModuleMember -Function *
