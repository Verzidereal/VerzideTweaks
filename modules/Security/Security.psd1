@{
    ModuleVersion     = '1.0.0'
    GUID              = 'c7de83ba-7ab1-4b2f-9eb3-6d3327a21306'
    Author            = 'Verzide'
    CompanyName       = 'VerzideTweaks'
    Description       = 'Security-related tweaks including safe debloat, firewall presets, Windows Defender control and integrity settings.'

    RootModule        = 'Security.psm1'
    FunctionsToExport = @(
        'Disable-WindowsDefender',
        'Enable-WindowsDefender',
        'Apply-FirewallGamingPreset',
        'Apply-PrivacyTweaks',
        'Remove-MalwareApps'
    )

    PowerShellVersion = '5.1'
}
