Write-Host "Manual Tweak Selection"
Write-Host "======================"
Write-Host ""
Write-Host "1) System Tweaks"
Write-Host "2) Network Tweaks"
Write-Host "3) Gaming Tweaks"
Write-Host "4) Security Tweaks"
Write-Host "0) Back"
Write-Host ""

$input = Read-Host "Choose"

switch ($input) {
    "1" {
        Optimize-Services
        Cleanup-System
        Set-PowerPlan
    }
    "2" {
        Optimize-TCP
        Disable-Nagle
        Set-DNS
        Optimize-NetworkAdapter
    }
    "3" {
        Optimize-GPU
        Reduce-InputLag
        Optimize-Scheduler
    }
    "4" {
        Apply-PrivacyTweaks
        Remove-MalwareApps
    }
    "0" { return }
}
