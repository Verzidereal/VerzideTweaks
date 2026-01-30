# =====================================
# Performance.psm1 – System, CPU, GPU, OS optimizations
# =====================================

<#
.SYNOPSIS
Module providing performance, latency and OS optimization functions.
#>

function Optimize-Services {
<#
.SYNOPSIS
Disables non-essential services for performance.
.PARAMETER Safe
Runs safer preset (no Xbox, biometrics, error reporting).
#>
    param([switch]$Safe)

    Write-Host "[+] Optimizing Windows services..."

    $services = if ($Safe) {
        @("DiagTrack","SysMain","WSearch")
    } else {
        @(
            "DiagTrack", "SysMain", "WSearch", "MapsBroker",
            "WbioSrvc", "XblAuthManager", "XblGameSave", "WerSvc"
        )
    }

    foreach ($svc in $services) {
        if (Get-Service -Name $svc -ErrorAction SilentlyContinue) {
            Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
            Write-Host " ✓ $svc disabled"
        }
    }
}

function Optimize-Registry {
<#
.SYNOPSIS
Applies safe general performance registry tweaks.
#>
    Write-Host "[+] Applying safe performance registry tweaks..."

    reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d 0 /f
    reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 10 /f

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v NtfsMemoryUsage /t REG_DWORD /d 2 /f
    powercfg -hibernate off 2>$null

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" `
        /v LargeSystemCache /t REG_DWORD /d 1 /f
}

function Optimize-RegistryLowLatency {
<#
.SYNOPSIS
Adds low latency system tweaks.
#>
    Write-Host "[+] Applying low-latency registry tweaks..."

    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" `
        /v SystemResponsiveness /t REG_DWORD /d 0 /f

    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" `
        /v "GPU Priority" /t REG_DWORD /d 8 /f

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" `
        /v TcpDelAckTicks /t REG_DWORD /d 0 /f
}

function Optimize-RegistryAggressive {
<#
.SYNOPSIS
Combines all registry tweaks + aggressive settings.
#>
    Write-Host "[+] Applying AGGRESSIVE performance tweaks..."

    Optimize-Registry
    Optimize-RegistryLowLatency

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" `
        /v EnablePrefetcher /t REG_DWORD /d 0 /f

    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" `
        /v EnableSuperfetch /t REG_DWORD /d 0 /f
}

function Disable-Animations {
<#
.SYNOPSIS
Disables UI animations for a snappier desktop experience.
#>
    Write-Host "[+] Disabling UI animations..."

    # Cleanest and safest effects removal
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" `
        /v VisualFXSetting /t REG_DWORD /d 2 /f
}

function Disable-VisualEffects {
<#
.SYNOPSIS
Disables heavy Windows visual effects for max performance.
#>
    Write-Host "[+] Disabling heavy visual effects..."

    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
}

function Set-ProcessorScheduling {
<#
.SYNOPSIS
Sets processor scheduling for Gaming, Programs, or Background tasks.
.PARAMETER Mode
Programs/Gaming/Background
#>
    param([ValidateSet("Programs","Gaming","Background")]$Mode)

    Write-Host "[+] Setting processor scheduling to $Mode..."

    if ($Mode -in @("Gaming","Programs")) {
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" `
            /v Win32PrioritySeparation /t REG_DWORD /d 26 /f
    }
    elseif ($Mode -eq "Background") {
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" `
            /v Win32PrioritySeparation /t REG_DWORD /d 18 /f
    }
}

function Cleanup-Temp {
<#
.SYNOPSIS
Cleans temporary user and Windows files.
#>
    Write-Host "[+] Cleaning temporary system files..."

    Get-ChildItem $env:TEMP -Recurse -Force -ErrorAction SilentlyContinue | 
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host " ✓ Temp folder cleaned"

    cmd.exe /c "del /s /q C:\Windows\Temp\*" 2>$null
    Write-Host " ✓ Windows Temp cleaned"
}

function Full-SystemCleanup {
<#
.SYNOPSIS
Runs a full cleanup including Disk Cleanup presets.
#>
    Write-Host "[+] Running full system cleanup..."

    Cleanup-Temp
    Start-Process cleanmgr.exe "/sagerun:1" -WindowStyle Hidden
}

function Enable-UltimatePerformance {
<#
.SYNOPSIS
Enables the Ultimate Performance power scheme.
#>
    Write-Host "[+] Selecting Ultimate Performance plan..."

    $id = "e9a42b02-d5df-448d-aa00-03f14749eb61"
    powercfg -duplicatescheme $id 2>$null
    powercfg -setactive $id

    Write-Host " ✓ Ultimate Performance enabled"
}

Export-ModuleMember -Function *
