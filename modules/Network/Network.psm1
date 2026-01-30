# ==================================================
# Network.psm1 – Full Aggressive Network Tweaks
# ==================================================

function Set-DNSFast {
    Write-Host "[Network] Applying Fast DNS (Cloudflare + Google)..." -ForegroundColor Cyan

    $dnsServers = @("1.1.1.1", "1.0.0.1", "8.8.8.8", "8.8.4.4")
    $adapters = Get-DnsClientServerAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue

    foreach ($adapter in $adapters) {
        Set-DnsClientServerAddress `
            -InterfaceIndex $adapter.InterfaceIndex `
            -ServerAddresses $dnsServers `
            -ErrorAction SilentlyContinue
    }

    Write-Host " [+] DNS applied to all adapters."
}

function Set-TCPGamingMode {
    Write-Host "[Network] Applying modern TCP gaming tweaks..." -ForegroundColor Cyan

    $commands = @(
        "netsh int tcp set global autotuninglevel=disabled",
        "netsh int tcp set global rss=enabled",
        "netsh int tcp set global ecncapability=disabled",
        "netsh int tcp set global timestamps=disabled",
        "netsh int tcp set global pacingprofile=off",
        "netsh int tcp set supplemental template=internet congestionprovider=ctcp"
    )

    foreach ($cmd in $commands) {
        Invoke-Expression $cmd
    }

    Write-Host " [+] TCP Gaming Mode optimized."
}

function Disable-NetworkQoS {
    Write-Host "[Network] Disabling QoS Packet Scheduler (lowest latency)..." -ForegroundColor Cyan

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f | Out-Null
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Psched" /v Start /t REG_DWORD /d 4 /f | Out-Null

    Write-Host " [+] QoS disabled."
}

function Reset-NetworkStack {
    Write-Host "[Network] Performing FULL stack reset..." -ForegroundColor Cyan

    netsh winsock reset | Out-Null
    netsh int ip reset | Out-Null

    ipconfig /flushdns | Out-Null

    Write-Host " [+] Network stack fully reset."
}

function Clean-NetworkInterfaces {
    Write-Host "[Network] Cleaning old WiFi profiles..." -ForegroundColor Cyan

    $profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object {
        $_.ToString().Split(":")[1].Trim()
    }

    foreach ($profile in $profiles) {
        netsh wlan delete profile name="$profile" | Out-Null
        Write-Host " [+] Removed WiFi profile: $profile"
    }

    Write-Host " [+] WiFi profiles cleaned."
}

function Optimize-WiFiLatency {
    Write-Host "[Network] Applying WiFi latency optimization..." -ForegroundColor Cyan

    $regEdits = @{
        "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc\Parameters" = @{ DisableScanWhileConnected = 1 }
        "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"   = @{ TcpAckFrequency = 1; TCPNoDelay = 1 }
        "HKLM\SOFTWARE\Microsoft\WlanSvc\Roaming"                   = @{ RoamDecision = 0; RoamEnable = 0; RoamDelta = 20 }
    }

    foreach ($key in $regEdits.Keys) {
        New-Item -Path $key -Force | Out-Null
        foreach ($name in $regEdits[$key].Keys) {
            reg add $key /v $name /t REG_DWORD /d $($regEdits[$key][$name]) /f | Out-Null
        }
    }

    Write-Host " [+] WiFi latency minimized."
}

function Optimize-Ethernet {
    Write-Host "[Network] Optimizing Ethernet performance..." -ForegroundColor Cyan

    $ethernet = Get-NetAdapter | Where-Object { $_.Status -eq "Up" -and $_.InterfaceDescription -notmatch "Wi-Fi" }

    foreach ($adapter in $ethernet) {
        Write-Host " [+] Optimizing: $($adapter.Name)"

        Set-NetIPInterface -InterfaceIndex $adapter.ifIndex -NlMtu 1500 -ErrorAction SilentlyContinue
        netsh interface ipv4 set global icmpredirects=disabled | Out-Null

        reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$($adapter.InterfaceGuid)" /v TcpAckFrequency /t REG_DWORD /d 1 /f | Out-Null
        reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$($adapter.InterfaceGuid)" /v TCPNoDelay /t REG_DWORD /d 1 /f | Out-Null
    }

    Write-Host " [+] Ethernet fully optimized."
}

function Apply-NetworkAggressivePreset {
    Write-Host "`n========== FULL NETWORK AGGRESSIVE PRESET ==========" -ForegroundColor Cyan

    Set-DNSFast
    Set-TCPGamingMode
    Disable-NetworkQoS
    Optimize-WiFiLatency
    Optimize-Ethernet

    Write-Host "`n[✔] All network tweaks applied successfully!" -ForegroundColor Green
}

Export-ModuleMember -Function *
