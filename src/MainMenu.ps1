<# ============================================================
    VerzideTweaks – Main Menu
    Author: Verzide
    Modular FPS & System Optimization Tool
============================================================ #>

# Load Modules
$ModulePath = "$PSScriptRoot/../modules"

if (!(Test-Path $ModulePath)) {
    Write-Host "[ERROR] Modules folder not found: $ModulePath" -ForegroundColor Red
    exit
}

Get-ChildItem "$ModulePath/*.psm1" | ForEach-Object {
    try {
        Import-Module $_.FullName -Force
        Write-Host "[Loaded] $($_.Name)" -ForegroundColor Green
    } catch {
        Write-Host "[ERROR] Failed to load module: $($_.Name)" -ForegroundColor Red
    }
}

function Show-Menu {
    Clear-Host
    Write-Host "==============================================" -ForegroundColor DarkCyan
    Write-Host "           VERZIDE SYSTEM TWEAK TOOL          " -ForegroundColor Cyan
    Write-Host "==============================================" -ForegroundColor DarkCyan
    Write-Host ""
    Write-Host " 1) Performance Tweaks"
    Write-Host " 2) Network Tweaks"
    Write-Host " 3) Windows Debloat"
    Write-Host " 4) Gaming Optimization"
    Write-Host " 5) Apply Full Preset (Recommended)"
    Write-Host " 6) Exit"
    Write-Host ""
}

function Run-Option {
    param([int]$Choice)

    switch ($Choice) {

        1 {
            Write-Host "[Running] Performance Tweaks..." -ForegroundColor Cyan
            Start-PerformanceTweaks
            Pause
        }

        2 {
            Write-Host "[Running] Network Tweaks..." -ForegroundColor Cyan
            Start-NetworkTweaks
            Pause
        }

        3 {
            Write-Host "[Running] Windows Debloat..." -ForegroundColor Cyan
            Start-WindowsDebloat
            Pause
        }

        4 {
            Write-Host "[Running] Gaming Optimization..." -ForegroundColor Cyan
            Start-GamingOptimizations
            Pause
        }

        5 {
            Write-Host "[Running] Full recommended preset..." -ForegroundColor Cyan
            Start-FullPreset
            Pause
        }

        6 {
            Write-Host "Exiting..." -ForegroundColor Yellow
            exit
        }

        default {
            Write-Host "[Error] Invalid option." -ForegroundColor Red
            Pause
        }
    }
}

# Main Loop
while ($true) {
    Show-Menu
    $Choice = Read-Host "Select an option"
    Run-Option -Choice $Choice
}
