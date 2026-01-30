Write-Host "[Balanced Preset] Applying balanced performance tweaks..." -ForegroundColor Cyan

# ─────────────────────────────
# Load Modules Safely
# ─────────────────────────────
$modules = @(
    "$PSScriptRoot\..\Modules\Performance.psm1",
    "$PSScriptRoot\..\Modules\Network.psm1",
    "$PSScriptRoot\..\Modules\Gaming.psm1"
)

foreach ($m in $modules) {
    if (Test-Path $m) {
        Import-Module $m -Force
        Write-Host "• Loaded module: $(Split-Path $m -Leaf)" -ForegroundColor DarkGray
    } else {
        Write-Warning "Module missing: $m"
    }
}

# ─────────────────────────────
#  PERFORMANCE  (Balanced)
# ─────────────────────────────
Write-Host "[+] Applying performance tweaks..." -ForegroundColor Yellow

# En balanced NO activar Ultimate Performance
powercfg -setactive SCHEME_BALANCED

Optimize-Services -Safe
Optimize-Registry

# ─────────────────────────────
#  NETWORK (Balanced)
# ─────────────────────────────
Write-Host "[+] Applying balanced network tweaks..." -ForegroundColor Yellow

# Balanced = DNS rápido + sin agresividad
Set-DNSFast   # ya existe en Network.psm1

# Evitar Apply-NetworkBalanced (no existe)
# Usamos una versión suave de gaming TCP tweaks:
netsh int tcp set global autotuninglevel=normal | Out-Null
netsh int tcp set global ecncapability=disabled | Out-Null

Write-Host " ✓ Network balanced tweaks applied" -ForegroundColor DarkGreen

# ─────────────────────────────
#  GAMING (Balanced)
# ─────────────────────────────
Write-Host "[+] Applying gaming optimizations..." -ForegroundColor Yellow

Enable-GameMode
Disable-XboxOverlays

# (No aplicar HAGS/MPO/NVIDIA tweaks—son agresivos) 

# ─────────────────────────────
#  DONE
# ─────────────────────────────
Write-Host "`n✓ Balanced preset applied." -ForegroundColor Green
