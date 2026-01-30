@{
    ModuleVersion     = '1.0.0'
    GUID              = '5b12e836-2c04-4fb2-8cb1-2f48e5d42d33'
    Author            = 'Verzide'
    CompanyName       = 'VerzideTweaks'
    Description       = 'High-performance gaming tweaks including GPU, scheduler, input latency and FPS optimizations.'

    RootModule        = 'Gaming.psm1'
    FunctionsToExport = @(
        'Optimize-GPU',
        'Optimize-Scheduler',
        'Optimize-WindowsGamingSettings',
        'Enable-UltimatePerformance',
        'Reduce-InputLag'
    )

    PowerShellVersion = '5.1'
}

