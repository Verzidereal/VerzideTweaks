function Optimize-TCP {
    Write-Host "[+] Applying TCP optimizations..."

    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpAckFrequency /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNoDelay /t REG_DWORD /d 1 /f
    reg add "HKLM\Software\Microsoft\MSMQ\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f
}

function Disable-Nagle {
    Write-Host "[+] Disabling Nagle's Algorithm..."

    $interfaces = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"

    foreach ($iface in $interfaces) {
        reg add "$($iface.Name)" /v TcpAckFrequency /t REG_DWORD /d 1 /f
        reg add "$($iface.Name)" /v TcpNoDelay /t REG_DWORD /d 1 /f
    }
}

function Set-DNS {
    Write-Host "[+] Setting optimized DNS (Cloudflare + Google)"

    $dns = "1.1.1.1","1.0.0.1","8.8.8.8","8.8.4.4"

    Get-DnsClientServerAddress | ForEach-Object {
        Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ServerAddresses $dns
    }
}

function Flush-Network {
    Write-Host "[+] Flushing network stack..."

    ipconfig /flushdns
    netsh int ip reset
    netsh winsock reset
}

function Optimize-NetworkAdapter {
    Write-Host "[+] Optimizing network adapter features..."

    $adapter = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}

    foreach ($nic in $adapter) {
        Set-NetAdapterAdvancedProperty -Name $nic.Name -DisplayName "Energy Efficient Ethernet" -DisplayValue "Disabled" -ErrorAction SilentlyContinue
        Set-NetAdapterAdvancedProperty -Name $nic.Name -DisplayName "Interrupt Moderation" -DisplayValue "Disabled" -ErrorAction SilentlyContinue
    }
}
