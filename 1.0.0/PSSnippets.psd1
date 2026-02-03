@{
    ModuleVersion        = '1.0.0'
    GUID                 = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
    Author               = 'Dave Edwards'
    CompanyName          = 'Personal'
    Copyright            = '(c) 2026. All rights reserved.'
    Description          = 'PowerShell module for managing code snippets'
    PowerShellVersion    = '5.1'
    CompatiblePSEditions = @('Desktop', 'Core')
    RootModule           = 'PSSnippets.psm1'
    HelpInfoUri          = 'https://github.com/soulhakr/PSSnippets#readme'
    FunctionsToExport    = @(
        'Get-Snippet',
        'Invoke-Snippet',
        'New-Snippet',
        'Set-Snippet',
        'Remove-Snippet',
        'Export-Snippet',
        'Export-SnippetToMarkdown'
    )
    RequiredModules      = @()
    RequiredAssemblies   = @()
    ScriptsToProcess     = @()
    TypesToProcess       = @()
    FormatsToProcess     = @()
    CmdletsToExport      = @()
    VariablesToExport    = @()
    AliasesToExport      = @()
    FileList             = @(
        'PSSnippets.psd1',
        'PSSnippets.psm1'
    )
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Snippets', 'CodeManagement', 'Productivity')
            ProjectUri                 = 'https://github.com/soulhakr/PSSnippets'
            ReleaseNotes               = 'Initial release of PSSnippets module'
            LicenseUri                 = 'https://github.com/soulhakr/PSSnippets/blob/main/LICENSE'
            ExternalModuleDependencies = @()
        }
    }
}
