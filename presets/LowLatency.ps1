Write-Host "[MAX FPS PRESET] Applying extreme performance tweaks..." -ForegroundColor Red

# Load modules
Import-Module "$PSScriptRoot\..\Modules\Performance.psm1" -Force
Import-Module "$PSScriptRoot\..\Modules\Network.psm1" -Force
Import-Module "$PSScriptRoot\..\Modules\Gaming.psm1" -Force
Import-Module "$PSScriptRoot\..\Modules\Security.psm1" -Force

# =======================================
# SYSTEM PERFORMANCE
# =======================================
Write-Host "[+] Boosting system performance..." -ForegroundColor Yellow

Enable-UltimatePerformance        # Fuerza modo de energía extremo
Disable-BackgroundServices        # Mata servicios no críticos
Optimize-RegistryAggressive       # Tweak de registro + desfragmentación de hive
Disable-Animations                # Sin animaciones para reducir input delay
Disable-VisualEffects             # Estilo Windows 2000 pero mínimo lag

# GPU & TIMER
# =======================================
Write-Host "[+] Applying GPU & rendering optimizations..." -ForegroundColor Yellow

Apply-GPURenderTweaks             # GPU scheduling, hardware acceleration, VRR
Apply-TimerResolution             # 0.5 ms (si el hardware lo soporta)
Force-HighPerformanceGPU          # Para laptops con GPU dual

# =======================================
# NETWORK PERFORMANCE (TOURNAMENT MODE)
# =======================================
Write-Host "[+] Applying tournament-grade network tweaks..." -ForegroundColor Yellow

Apply-NetworkTournamentMode        # Deshabilita Nagle, ECN, RSS tuning
Apply-DNSGaming                    # DNS ultra rápidos (Cloudflare/Quad9)
Disable-PowerSavingNetwork         # Sin ahorro de energía en NIC
Apply-TCPGamingMode                # Custom congestion provider + throughput tweaks

# =======================================
# GAMING SPECIFIC
# =======================================
Write-Host "[+] Applying gaming optimizations..." -ForegroundColor Yellow

Apply-FullGamingPreset             # Prioridad juegos, modo juego, HAGS, VRR
Optimize-GameProcesses             # Win32PrioritySeparation, QoS, CSRSS tweaks

# =======================================
# SECURITY LITE (SAFE)
# =======================================
Write-Host "[+] Applying safe lightweight security profile..." -ForegroundColor Yellow

Disable-DefenderNonCritical        # Mantiene protección principal
Optimize-FirewallGaming            # Reglas UDP + optimización firewall

# =======================================
Write-Host "✓ MAX FPS preset successfully applied." -ForegroundColor Green
