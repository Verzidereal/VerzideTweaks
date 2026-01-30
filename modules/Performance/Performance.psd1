@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'Performance.psm1'

    ModuleVersion = '1.0.0'
    GUID = 'de42bb0b-12f3-4c88-9f6d-a2b582a3c82d'

    Author = 'Verzide'
    CompanyName = 'Verzide Tweaks'
    Copyright = '(c) Verzide. All rights reserved.'

    Description = 'Performance optimization module for VerzideTweaks.'

    PowerShellVersion = '5.1'

    FunctionsToExport = @(
        'Optimize-Services',
        'Optimize-Registry',
        'Optimize-RegistryLowLatency',
        'Optimize-RegistryAggressive',
        'Disable-Animations',
        'Disable-VisualEffects',
        'Set-ProcessorScheduling',
        'Cleanup-Temp',
        'Full-SystemCleanup',
        'Enable-UltimatePerformance'
    )

    FileList = @(
        'Performance.psm1'
    )

    PrivateData = @{
        PSData = @{
            Tags = @('Performance','Gaming','FPS','Tweaks','Windows')
        }
    }
}
