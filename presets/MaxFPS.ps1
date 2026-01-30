Write-Host "[Preset] Applying MaxFPS preset..." -ForegroundColor Red

# ============================================================
# Helper para verificar si existe una función antes de llamarla
# ============================================================
function Invoke-IfExists {
    param(
        [string]$FunctionName
    )
    if (Get-Command $FunctionName -ErrorAction SilentlyContinue) {
        Write-Host " [+] Executing $FunctionName" -ForegroundColor Yellow
        & $FunctionName
    }
    else {
        Write-Host " [!] Missing function: $FunctionName" -ForegroundColor DarkYellow
    }
}

# ============================================================
# EJECUCIÓN ORDENADA DEL PRESET
# ============================================================

Write-Host "`n=== SYSTEM CLEANUP ===" -ForegroundColor Cyan
Invoke-IfExists "Disable-Cortana"
Invoke-IfExists "Disable-Bloatware"

Write-Host "`n=== GPU & RENDER OPTIMIZATION ===" -ForegroundColor Cyan
Invoke-IfExists "Optimize-GPU"

Write-Host "`n=== CPU & SCHEDULER ===" -ForegroundColor Cyan
Invoke-IfExists "Optimize-Scheduler"

Write-Host "`n=== NETWORK STACK OPTIMIZATION ===" -ForegroundColor Cyan
Invoke-IfExists "Optimize-TCP"
Invoke-IfExists "Disable-Nagle"
Invoke-IfExists "Optimize-NetworkAdapter"

Write-Host "`n=== POWER & ENERGY MODE ===" -ForegroundColor Cyan
Invoke-IfExists "Enable-UltimatePerformance"

# ============================================================

Write-Host "`n[MaxFPS] Done!" -ForegroundColor Green
