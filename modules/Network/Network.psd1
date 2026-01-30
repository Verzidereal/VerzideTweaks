@{
    ModuleVersion     = '1.0.0'
    GUID              = '3c71b8a9-3eee-4c99-94d4-8bb555f70f88'
    Author            = 'Verzide'
    CompanyName       = 'VerzideTweaks'
    Description       = 'Network tweaks focused on latency reduction, packet optimization, and gaming routing.'

    RootModule        = 'Network.psm1'
    FunctionsToExport = @(
        'Optimize-TCP',
        'Disable-Nagle',
        'Set-DNS',
        'Flush-Network',
        'Optimize-NetworkAdapter'
    )

    PowerShellVersion = '5.1'
}

