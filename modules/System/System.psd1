
@{
    ModuleVersion     = '1.0.0'
    GUID              = 'a1aa1fa3-9d54-4f9c-8ac1-8e91fb07f201'
    Author            = 'Verzide'
    CompanyName       = 'VerzideTweaks'
    Copyright         = 'Copyright (c) Verzide'
    Description       = 'System optimization tweaks for performance, latency reduction, and OS cleanup.'

    RootModule        = 'System.psm1'
    FunctionsToExport = @(
        'Optimize-Services',
        'Disable-Cortana',
        'Disable-Bloatware',
        'Cleanup-System',
        'Set-HPET',
        'Set-PowerPlan'
    )

    PowerShellVersion = '5.1'
}
