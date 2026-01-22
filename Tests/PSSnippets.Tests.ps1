# Pester tests for PSSnippets

Describe 'PSSnippets module manifest' {
    BeforeAll {
        if (-not $script:manifestPath) {
            $script:moduleRoot = Split-Path -Path $PSScriptRoot -Parent
            $script:manifestPath = Join-Path -Path $script:moduleRoot -ChildPath '1.0.0/PSSnippets.psd1'
        }
        Import-Module -Name $script:manifestPath -Force
    }

    It 'has a manifest file' {
        Test-Path $script:manifestPath | Should -BeTrue
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

Describe 'Snippet management cmdlets' {
    BeforeAll {
        if (-not $script:manifestPath) {
            $script:moduleRoot = Split-Path -Path $PSScriptRoot -Parent
            $script:manifestPath = Join-Path -Path $script:moduleRoot -ChildPath '1.0.0/PSSnippets.psd1'
        }
        Import-Module -Name $script:manifestPath -Force

        function Initialize-TestSnippetStore {
            param([Parameter(Mandatory)][string]$Path)

            $sampleData = @{
                snippets = @(
                    @{
                        name        = 'Reload Profile'
                        description = 'Reloads the current PowerShell profile'
                        code        = 'Write-Output "Executed from snippet"'
                        language    = 'powershell'
                        tags        = @('profile', 'utility')
                        created     = (Get-Date).ToString('o')
                    },
                    @{
                        name        = 'List Services'
                        description = 'Lists running services'
                        code        = 'Get-Service | Where-Object { $_.Status -eq "Running" }'
                        language    = 'powershell'
                        tags        = @('system')
                        created     = (Get-Date).AddDays(-1).ToString('o')
                    }
                )
            }

            $sampleData | ConvertTo-Json -Depth 10 | Set-Content -Path $Path -Encoding UTF8
        }

        function Get-TestSnippetData {
            Get-Content -Path $env:SNIPPETS_HOME -Raw | ConvertFrom-Json
        }

        function New-TestDirectory {
            $dir = Join-Path -Path ([IO.Path]::GetTempPath()) -ChildPath ('pssnippets-tests-{0}' -f ([guid]::NewGuid()))
            New-Item -ItemType Directory -Path $dir | Out-Null
            return $dir
        }
    }

    BeforeEach {
        $script:tempSnippetFile = Join-Path -Path ([IO.Path]::GetTempPath()) -ChildPath ('pssnippets-store-{0}.json' -f ([guid]::NewGuid()))
        Initialize-TestSnippetStore -Path $script:tempSnippetFile
        $script:previousSnippetsHome = if (Test-Path env:SNIPPETS_HOME) { $env:SNIPPETS_HOME } else { $null }
        $env:SNIPPETS_HOME = $script:tempSnippetFile
    }

    AfterEach {
        if ($script:tempSnippetFile -and (Test-Path $script:tempSnippetFile)) {
            Remove-Item -Path $script:tempSnippetFile -Force
        }

        if ($null -ne $script:previousSnippetsHome) {
            $env:SNIPPETS_HOME = $script:previousSnippetsHome
        } else {
            Remove-Item Env:SNIPPETS_HOME -ErrorAction SilentlyContinue
        }
    }

    Context 'Get-Snippet and Invoke-Snippet' {
        It 'returns snippets by wildcard match' {
            $result = Get-Snippet -Name 'Reload'

            $result | Should -Not -BeNullOrEmpty
            $result.Name | Should -Contain 'Reload Profile'
        }

        It 'executes the snippet code and returns output' {
            $output = Invoke-Snippet -Name 'Reload Profile'

            $output | Should -BeExactly 'Executed from snippet'
        }
    }

    Context 'New-Snippet operations' {
        It 'adds a new snippet to the store' {
            New-Snippet -Name 'Test-New' -Description 'Demo snippet' -Code 'Write-Output "demo"' -Tags 'demo'

            $data = Get-TestSnippetData
            ($data.snippets | Where-Object { $_.name -eq 'Test-New' }).Count | Should -Be 1
        }

        It 'does not allow duplicate snippet names' {
            $initialCount = (Get-TestSnippetData).snippets.Count

            New-Snippet -Name 'Reload Profile' -Description 'Duplicate attempt' -Code 'Write-Output "duplicate"'

            (Get-TestSnippetData).snippets.Count | Should -Be $initialCount
        }
    }

    Context 'Set-Snippet and Remove-Snippet' {
        It 'renames an existing snippet and updates metadata' {
            Set-Snippet -Name 'Reload Profile' -NewName 'Reload Profile v2' -Description 'Updated description'

            $data = Get-TestSnippetData
            $renamed = $data.snippets | Where-Object { $_.name -eq 'Reload Profile v2' }

            $renamed | Should -Not -BeNullOrEmpty
            $renamed.description | Should -Be 'Updated description'
        }

        It 'removes a snippet from the store' {
            Remove-Snippet -Name 'List Services'

            $names = (Get-TestSnippetData).snippets.name
            $names | Should -Not -Contain 'List Services'
        }
    }

    Context 'Export-Snippet' {
        It 'creates script files for matching snippets' {
            $exportDir = New-TestDirectory

            try {
                Export-Snippet -Name 'Reload Profile' -OutputPath $exportDir -IncludeDescription -Force | Out-Null

                $filePath = Join-Path -Path $exportDir -ChildPath 'Reload Profile.ps1'
                Test-Path $filePath | Should -BeTrue

                $content = Get-Content -Path $filePath -Raw
                $content | Should -Match '# Reloads the current PowerShell profile'
                $content | Should -Match 'Executed from snippet'
            } finally {
                if (Test-Path $exportDir) {
                    Remove-Item -Path $exportDir -Recurse -Force
                }
            }
        }
    }

    Context 'Export-SnippetToMarkdown' {
        It 'creates a markdown document with snippet details' {
            $outputDir = New-TestDirectory

            try {
                $markdownPath = Join-Path -Path $outputDir -ChildPath 'snippets.md'
                Export-SnippetToMarkdown -OutputPath $markdownPath -Title 'My Snippets' | Should -Not -BeNullOrEmpty

                Test-Path $markdownPath | Should -BeTrue
                $content = Get-Content -Path $markdownPath -Raw
                $content | Should -Match '# My Snippets'
                $content | Should -Match 'Reload Profile'
            } finally {
                if (Test-Path $outputDir) {
                    Remove-Item -Path $outputDir -Recurse -Force
                }
            }
        }
    }
}
