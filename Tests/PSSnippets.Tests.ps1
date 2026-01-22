# Pester tests for PSSnippets

$moduleRoot = Split-Path -Path $PSScriptRoot -Parent
$manifestPath = Join-Path -Path $moduleRoot -ChildPath "1.0.0/PSSnippets.psd1"

Describe 'PSSnippets module' {
    BeforeAll {
        Import-Module -Name $manifestPath -Force
    }

    It 'has a manifest file' {
        Test-Path $manifestPath | Should -BeTrue
    }

    It 'exports the expected functions' {
        $expectedFunctions = @(
            'Get-Snippet',
            'Invoke-Snippet',
            'New-Snippet',
            'Set-Snippet',
            'Remove-Snippet',
            'Export-Snippet',
            'Export-SnippetToMarkdown'
        )

        $commands = (Get-Command -Module PSSnippets).Name
        foreach ($function in $expectedFunctions) {
            $commands | Should -Contain $function
        }
    }
}
