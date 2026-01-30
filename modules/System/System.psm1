function Set-SystemPerformance {
    param(
        [ValidateSet("High","Balanced","PowerSaver")]
        [string]$Mode = "High"
    )

    Write-Host "[System] Cambiando modo de energía a: $Mode"

    switch ($Mode) {
        "High"        { powercfg -setactive SCHEME_MIN }
        "Balanced"    { powercfg -setactive SCHEME_BALANCED }
        "PowerSaver"  { powercfg -setactive SCHEME_MAX }
    }
}
Export-ModuleMember -Function *
