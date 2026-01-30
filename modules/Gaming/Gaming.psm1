# =====================================
# Gaming.psm1 – Full Aggressive Gaming Tweaks (Improved)
# =====================================

function Enable-GameMode {
<#
.SYNOPSIS
Enables Windows Game Mode.
#>
    Write-Host "[+] Enabling Game Mode & Gaming Features..."

    reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f

    reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f
    reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f

    Write-Host " ✓ GameMode enabled"
}

function Disable-XboxOverlays {
<#
.SYNOPSIS
Disables Xbox overlays, DVR, and captures.
#>
    Write-Host "[+] Disabling Xbox Game Bar + DVR + Captures..."

    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f
    reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AudioCaptureEnabled /t REG_DWORD /d 0 /f

    reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f

    Write-Host " ✓ Xbox overlays disabled"
}

function Enable-UltimatePerformance {
<#
.SYNOPSIS
Enables Ultimate Performance power plan.
#>
    Write-Host "[+] Setting Ultimate Performance power plan..."

    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>$null
    powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

    Write-Host " ✓ Ultimate Performance enabled"
}

function Apply-GPURenderTweaks {
<#
.SYNOPSIS
Enables HAGS, MPO fix, and VRR tuning.
#>
    Write-Host "[+] Applying GPU Scheduling + HAGS + MPO fixes..."

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\FeatureSet" /v VRRforDRRSupported /t REG_DWORD /d 1 /f

    Write-Host " ✓ GPU tweaks applied"
}

function Apply-TimerResolution {
<#
.SYNOPSIS
Tweaks power subsystem for lower timer latency.
#>
    Write-Host "[+] Setting Timer Resolution tweaks..."

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HpetEnabled /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v PlatformAoAcOverride /t REG_DWORD /d 0 /f

    Write-Host " ✓ Timer Resolution tweaks applied"
}

function Disable-BackgroundServices {
<#
.SYNOPSIS
Disables services that cause stutters during gaming.
#>
    Write-Host "[+] Disabling unnecessary background services..."

    $services = @(
        "DiagTrack",        # Telemetry
        "SysMain",          # Superfetch
        "WSearch",          # Indexing
        "XboxGipSvc",
        "XblAuthManager",
        "XblGameSave",
        "WbioSrvc"
    )

    foreach ($svc in $services) {
        Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
        Write-Host " ✓ Disabled: $svc"
    }
}

function Optimize-GameProcesses {
<#
.SYNOPSIS
Sets High priority for competitive games.
#>
    Write-Host "[+] Optimizing running game processes..."

    $games = @(
        "cs2", "fortniteclient-win64-shipping", "valorant",
        "r5apex", "mw2", "cod", "overwatch", "rocketleague"
    )

    foreach ($game in $games) {
        Get-Process -Name $game -ErrorAction SilentlyContinue | ForEach-Object {
            $_.PriorityClass = "High"
            Write-Host " ✓ Priority set: $game.exe"
        }
    }
}

function Apply-FullGamingPreset {
<#
.SYNOPSIS
Applies ALL aggressive gaming tweaks.
#>
    Write-Host "[+] Applying FULL AGGRESSIVE GAMING PRESET..."

    Enable-GameMode
    Disable-XboxOverlays
    Enable-UltimatePerformance
    Apply-GPURenderTweaks
    Apply-TimerResolution
    Disable-BackgroundServices

    Write-Host " ✓ All gaming optimizations applied!"
}

Export-ModuleMember -Function *
