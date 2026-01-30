function Optimize-GPU {
    Write-Host "[+] Applying GPU performance optimizations..."

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f
    reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f
}

function Optimize-Scheduler {
    Write-Host "[+] Reducing system scheduler latency..."

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 26 /f
}

function Optimize-WindowsGamingSettings {
    Write-Host "[+] Disabling game bar and DVR..."

    reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f
    reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f
    reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
}

function Enable-UltimatePerformance {
    Write-Host "[+] Enabling Ultimate Performance Power Plan..."
    powercfg -setactive SCHEME_MIN
}

function Reduce-InputLag {
    Write-Host "[+] Reducing input latency..."

    reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d "10" /f
    reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d "0" /f
}

