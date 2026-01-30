# =====================================
# Performance.psm1
# System performance, CPU, GPU and OS optimizations
# =====================================

function Optimize-Services {
    param(
        [switch]$Safe
    )

    Write-Host "[+] Optimizing Windows services..."

    $services = if ($Safe) {
        @("DiagTrack", "SysMain", "WSearch")
    } else {
        @(
            "DiagTrack",
            "SysMain",
            "WSearch",
            "MapsBroker",
            "WbioSrvc",
            "XblAuthManager",
            "XblGameSave",
            "WerSvc"
        )
    }

    foreach ($svc in $services) {
        Get-Service -Name $svc -ErrorAction SilentlyContinue | Set-Service -StartupType Disabled
        Write-Host " ✓ $svc disabled"
    }
}


function Optimize-Registry {
    Write-Host "[+] Applying safe performance registry tweaks..."

    # Mouse response
    reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d 0 /f

    # Menu speed
    reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 10 /f

    # File system performance
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsMemoryUsage /t REG_DWORD /d 2 /f

    # Disable hibernation
    powercfg -hibernate off 2>$null

    # IO performance
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" `
        /v LargeSystemCache /t REG_DWORD /d 1 /f
}


function Optimize-RegistryLowLatency {
    Write-Host "[+] Applying low-latency registry tweaks..."

    # SystemResponsiveness
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" `
        /v SystemResponsiveness /t REG_DWORD /d 0 /f

    # GPU priority
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" `
        /v GPU Priority /t REG_DWORD /d 8 /f

    # Network tweaks (generic)
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpDelAckTicks /t REG_DWORD /d 0 /f
}


function Optimize-RegistryAggressive {
    Write-Host "[+] Applying AGGRESSIVE performance tweaks..."

    Optimize-Registry
    Optimize-RegistryLowLatency

    # Disable prefetch/superfetch
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" `
        /v EnablePrefetcher /t REG_DWORD /d 0 /f

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" `
        /v EnableSuperfetch /t REG_DWORD /d 0 /f
}


function Disable-Animations {
    Write-Host "[+] Disabling UI animations..."

    reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
}


function Disable-VisualEffects {
    Write-Host "[+] Disabling heavy visual effects..."

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
}


function Set-ProcessorScheduling {
    param([ValidateSet("Programs","Gaming","Background")]$Mode)

    Write-Host "[+] Setting processor scheduling to $Mode..."

    if ($Mode -eq "Gaming" -or $Mode -eq "Programs") {
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" `
            /v Win32PrioritySeparation /t REG_DWORD /d 26 /f
    }

    if ($Mode -eq "Background") {
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" `
            /v Win32PrioritySeparation /t REG_DWORD /d 18 /f
    }
}


function Cleanup-Temp {
    Write-Host "[+] Cleaning temporary system files..."

    Get-ChildItem $env:TEMP -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host " ✓ Temp folder cleaned"

    cmd.exe /c "del /s /q C:\Windows\Temp\*" 2>$null
    Write-Host " ✓ Windows Temp cleaned"
}


function Full-SystemCleanup {
    Write-Host "[+] Running full system cleanup..."

    Cleanup-Temp
    Start-Process cleanmgr.exe "/sagerun:1" -WindowStyle Hidden
}


function Enable-UltimatePerformance {
    Write-Host "[+] Selecting Ultimate Performance plan..."

    $id = "e9a42b02-d5df-448d-aa00-03f14749eb61"
    powercfg -duplicatescheme $id 2>$null
    powercfg -setactive $id
    Write-Host " ✓ Ultimate Performance enabled"
}

Export-ModuleMember -Function *
