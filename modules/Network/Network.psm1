# ===============================
# Network.psm1 – Full Aggressive Tweaks
# ===============================

function Set-DNSFast {
    <#
        .SYNOPSIS
        Apply fast global DNS (Cloudflare + Google)
    #>
    Write-Host "[+] Applying Fast DNS settings..."

    $adapters = Get-DnsClientServerAddress -AddressFamily IPv4

    foreach ($adapter in $adapters) {
        Set-DnsClientServerAddress `
            -InterfaceIndex $adapter.InterfaceIndex `
            -ServerAddresses @("1.1.1.1","8.8.8.8") `
            -ErrorAction SilentlyContinue
    }

    Write-Host " ✓ DNS applied to all adapters"
}

function Set-TCPGamingMode {
    <#
        .SYNOPSIS
        Apply low-latency TCP settings optimized for gaming
    #>
    Write-Host "[+] Applying low-latency TCP tweaks..."

    netsh int tcp set global autotuninglevel=disabled
    netsh int tcp set global rss=enabled
    netsh int tcp set global chimney=enabled
    netsh int tcp set global ecncapability=disabled
    netsh int tcp set global timestamps=disabled
    netsh int tcp set global rsc=enabled
    netsh int tcp set security mpp=disabled

    Write-Host " ✓ TCP Gaming Mode enabled"
}

function Disable-NetworkQoS {
    <#
        .SYNOPSIS
        Disable QoS Packet Scheduler for lowest latency
    #>
    Write-Host "[+] Disabling QoS Packet Scheduler..."

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f

    Write-Host " ✓ QoS disabled"
}

function Reset-NetworkStack {
    <#
        .SYNOPSIS
        Full network stack reset (aggressive)
    #>
    Write-Host "[+] Resetting complete network stack..."

    netsh winsock reset
    netsh int ip reset
    ipconfig /release
    ipconfig /renew
    ipconfig /flushdns

    Write-Host " ✓ Network stack fully reset"
}

function Clean-NetworkInterfaces {
    <#
        .SYNOPSIS
        Remove stale network profiles and adapters
    #>
    Write-Host "[+] Cleaning unused network interfaces..."

    $profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object {
        $_.ToString().Split(":")[1].Trim()
    }

    foreach ($profile in $profiles) {
        netsh wlan delete profile name="$profile" | Out-Null
        Write-Host " ✓ Removed WiFi profile: $profile"
    }

    Write-Host " ✓ Interfaces cleaned"
}

function Optimize-WiFiLatency {
    <#
        .SYNOPSIS
        Apply tweaks specific to WiFi latency
    #>
    Write-Host "[+] Applying WiFi latency reduction..."

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc\Parameters" /v DisableScanWhileConnected /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpAckFrequency /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f

    Write-Host " ✓ WiFi optimized"
}

function Optimize-Ethernet {
    <#
        .SYNOPSIS
        Enable best performance settings for wired connections
    #>
    Write-Host "[+] Optimizing Ethernet performance..."

    netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
    netsh interface ipv4 set global icmpredirects=disabled

    Write-Host " ✓ Ethernet optimized"
}

function Apply-NetworkAggressivePreset {
    <#
        .SYNOPSIS
        Applies ALL network tweaks aggressively
    #>
    Write-Host "[+] Applying FULL Network Aggressive Preset..."

    Set-DNSFast
    Set-TCPGamingMode
    Disable-NetworkQoS
    Optimize-WiFiLatency
    Optimize-Ethernet

    Write-Host " ✓ All network tweaks applied!"
}

Export-ModuleMember -Function *
