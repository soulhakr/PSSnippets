function Get-Snippet {
    <#
    .SYNOPSIS
    Retrieves code snippets from the snippet library.
    
    .DESCRIPTION
    Searches for and returns code snippets that match the specified name pattern.
    Uses wildcard matching on the snippet name. The snippet file location is
    determined by the $env:SNIPPETS_HOME environment variable, or defaults to
    ~/.snippets.json if not set.
    
    .PARAMETER Name
    The name or partial name of the snippet to retrieve. Supports wildcard matching.
    
    .PARAMETER Language
    The programming language of the snippet. Defaults to 'powershell'.
    
    .PARAMETER Tags
    Optional tags to filter snippets by.
    
    .EXAMPLE
    Get-Snippet -Name "Profile"
    Retrieves all snippets with "Profile" in the name.
    
    .EXAMPLE
    "Reload" | Get-Snippet
    Retrieves snippets using pipeline input.
    
    .INPUTS
    System.String
    Accepts snippet names or objects with a Name property from the pipeline.

    .OUTPUTS
    PSCustomObject
    Returns snippet objects with name, description, and code properties.
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Language = 'powershell',
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$Tags = @()
    )
    $snippetFile = if ($env:SNIPPETS_HOME) { $env:SNIPPETS_HOME } else { Join-Path -Path $HOME -ChildPath '.snippets.json' }
    $snippets = Get-Content $snippetFile | ConvertFrom-Json
    $snippet = $snippets.snippets | Where-Object { $_.name -like "*$Name*" }
    if ($snippet) {
        $snippet | Select-Object -Property Name, Description, Code, Language, Tags, Created
    }
}

function Invoke-Snippet {
    <#
    .SYNOPSIS
    Executes a code snippet from the snippet library.
    
    .DESCRIPTION
    Retrieves and executes a snippet by exact name match using Invoke-Expression.
    The snippet file location is determined by the $env:SNIPPETS_HOME environment
    variable, or defaults to ~/.snippets.json if not set.
    
    .PARAMETER Name
    The exact name of the snippet to execute. This parameter is mandatory.
    
    .PARAMETER Language
    The programming language of the snippet. Defaults to 'powershell'.
    
    .PARAMETER Tags
    Optional tags to filter snippets by.
    
    .EXAMPLE
    Invoke-Snippet -Name "Reload Profile"
    Executes the snippet named "Reload Profile".
    
    .EXAMPLE
    "Show PSModulePath" | Invoke-Snippet
    Executes a snippet using pipeline input.
    
    .INPUTS
    System.String
    Accepts snippet names or objects with a Name property from the pipeline.

    .OUTPUTS
    System.Object
    Returns whatever the invoked snippet writes to the pipeline.

    .NOTES
    WARNING: This cmdlet uses Invoke-Expression to execute snippet code.
    Only run snippets from trusted sources.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Language = 'powershell',
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$Tags = @()
    )
    $snippetFile = if ($env:SNIPPETS_HOME) { $env:SNIPPETS_HOME } else { Join-Path -Path $HOME -ChildPath '.snippets.json' }
    $snippets = Get-Content $snippetFile | ConvertFrom-Json
    $snippet = $snippets.snippets | Where-Object { $_.name -eq $Name }
    if ($snippet) {
        Invoke-Expression $snippet.code
    }
}

function New-Snippet {
    <#
    .SYNOPSIS
    Creates a new code snippet in the snippet library.
    
    .DESCRIPTION
    Adds a new snippet with the specified name, description, and code to the
    snippet library. The snippet name must be unique. The snippet file location
    is determined by the $env:SNIPPETS_HOME environment variable, or defaults to
    ~/.snippets.json if not set.
    
    .PARAMETER Name
    The unique name for the snippet. This parameter is mandatory.
    
    .PARAMETER Description
    A description of what the snippet does. This parameter is mandatory.
    
    .PARAMETER Code
    The code content of the snippet. This parameter is mandatory.
    
    .PARAMETER Language
    The programming language of the snippet. Defaults to 'powershell'.
    
    .PARAMETER Tags
    Optional tags to categorize the snippet.
    
    .EXAMPLE
    New-Snippet -Name "List Files" -Description "List all files" -Code "Get-ChildItem"
    Creates a new snippet with the specified properties.
    
    .EXAMPLE
    [PSCustomObject]@{Name="Test"; Description="Test snippet"; Code="Write-Host 'test'"} | New-Snippet
    Creates a snippet using pipeline input.
    
    .INPUTS
    System.String, System.Management.Automation.PSCustomObject
    Accepts snippet definitions from the pipeline when properties match the parameter set.

    .OUTPUTS
    None
    Writes progress and warnings to the host only.

    .NOTES
    If a snippet with the same name already exists, a warning is displayed and
    no changes are made.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [string]$Description,
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName)]
        [string]$Code,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Language = 'powershell',
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$Tags = @()
    )
    $snippetFile = if ($env:SNIPPETS_HOME) { $env:SNIPPETS_HOME } else { Join-Path -Path $HOME -ChildPath '.snippets.json' }
    $snippets = Get-Content $snippetFile | ConvertFrom-Json
    
    # Check if snippet already exists
    if ($snippets.snippets | Where-Object { $_.name -eq $Name }) {
        Write-Warning "Snippet '$Name' already exists. Use a different name or remove it first."
        return
    }
    
    # Add new snippet
    $newSnippet = [PSCustomObject]@{
        name        = $Name
        description = $Description
        code        = $Code
        language    = $Language
        tags        = $Tags
        created     = (Get-Date).ToString('o')
    }
    $snippets.snippets += $newSnippet
    
    # Save to file
    $snippets | ConvertTo-Json -Depth 10 | Set-Content $snippetFile
    Write-Host "Snippet '$Name' added successfully." -ForegroundColor Green
}

function Set-Snippet {
    <#
    .SYNOPSIS
    Updates an existing code snippet in the snippet library.
    
    .DESCRIPTION
    Modifies properties of an existing snippet including its name, description,
    and code. Only the properties that are specified will be updated. The snippet
    file location is determined by the $env:SNIPPETS_HOME environment variable,
    or defaults to ~/.snippets.json if not set.
    
    .PARAMETER Name
    The current name of the snippet to update. This parameter is mandatory.
    
    .PARAMETER NewName
    The new name for the snippet. If specified, validates that the new name
    doesn't conflict with existing snippets.
    
    .PARAMETER Description
    The new description for the snippet.
    
    .PARAMETER Code
    The new code content for the snippet.
    
    .PARAMETER Language
    The programming language of the snippet. Defaults to 'powershell'.
    
    .PARAMETER Tags
    Optional tags to categorize the snippet.
    
    .EXAMPLE
    Set-Snippet -Name "Old Name" -NewName "New Name"
    Renames a snippet.
    
    .EXAMPLE
    Set-Snippet -Name "Test" -Description "Updated description" -Code "New code"
    Updates the description and code of a snippet.
    
    .EXAMPLE
    Get-Snippet "Test" | Set-Snippet -Description "New description"
    Updates a snippet using pipeline input.
    
    .INPUTS
    System.String, System.Management.Automation.PSCustomObject
    Accepts snippet names or objects with a Name property from the pipeline.

    .OUTPUTS
    None
    Writes status messages to the host only.

    .NOTES
    If the snippet is not found or the new name conflicts with an existing
    snippet, a warning is displayed and no changes are made.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$NewName,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Description,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Code,
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]$Language = 'powershell',
        [Parameter(ValueFromPipelineByPropertyName)]
        [string[]]$Tags = @()
    )
    $snippetFile = if ($env:SNIPPETS_HOME) { $env:SNIPPETS_HOME } else { Join-Path -Path $HOME -ChildPath '.snippets.json' }
    $snippets = Get-Content $snippetFile | ConvertFrom-Json
    
    # Find the snippet to update
    $snippet = $snippets.snippets | Where-Object { $_.name -eq $Name }
    
    if (-not $snippet) {
        Write-Warning "Snippet '$Name' not found."
        return
    }
    
    # Update properties if provided
    if ($NewName) {
        # Check if new name conflicts with existing snippet
        if ($NewName -ne $Name -and ($snippets.snippets | Where-Object { $_.name -eq $NewName })) {
            Write-Warning "A snippet named '$NewName' already exists."
            return
        }
        $snippet.name = $NewName
    }
    if ($Description) { $snippet.description = $Description }
    if ($Code) { $snippet.code = $Code }
    if ($Language) { $snippet.language = $Language }
    if ($Tags) { $snippet.tags = $Tags }
    # Preserve created timestamp (don't modify it)
    
    # Save to file
    $snippets | ConvertTo-Json -Depth 10 | Set-Content $snippetFile
    Write-Host "Snippet '$Name' updated successfully." -ForegroundColor Green
}

function Remove-Snippet {
    <#
    .SYNOPSIS
    Removes a code snippet from the snippet library.
    
    .DESCRIPTION
    Deletes a snippet by name from the snippet library. The snippet file location
    is determined by the $env:SNIPPETS_HOME environment variable, or defaults to
    ~/.snippets.json if not set.
    
    .PARAMETER Name
    The exact name of the snippet to remove. This parameter is mandatory.
    
    .EXAMPLE
    Remove-Snippet -Name "Old Snippet"
    Removes the snippet named "Old Snippet".
    
    .EXAMPLE
    "Temporary Snippet" | Remove-Snippet
    Removes a snippet using pipeline input.
    
    .EXAMPLE
    Get-Snippet "Test" | Remove-Snippet
    Finds and removes a snippet using pipeline.
    
    .INPUTS
    System.String, System.Management.Automation.PSCustomObject
    Accepts snippet names or objects with a Name property from the pipeline.

    .OUTPUTS
    None
    Writes warning or confirmation messages to the host only.

    .NOTES
    If the snippet is not found, a warning is displayed and no changes are made.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name
    )
    $snippetFile = if ($env:SNIPPETS_HOME) { $env:SNIPPETS_HOME } else { Join-Path -Path $HOME -ChildPath '.snippets.json' }
    $snippets = Get-Content $snippetFile | ConvertFrom-Json
    
    # Find and remove snippet
    $originalCount = $snippets.snippets.Count
    $snippets.snippets = $snippets.snippets | Where-Object { $_.name -ne $Name }
    
    if ($snippets.snippets.Count -eq $originalCount) {
        Write-Warning "Snippet '$Name' not found."
        return
    }
    
    # Save to file
    $snippets | ConvertTo-Json -Depth 10 | Set-Content $snippetFile
    Write-Host "Snippet '$Name' removed successfully." -ForegroundColor Green
}

function Export-Snippet {
    <#
    .SYNOPSIS
    Exports one or more snippets to individual script files.
    
    .DESCRIPTION
    Retrieves snippets from the library and exports them as individual script files.
    The file extension is determined by the snippet's language property (.ps1 for
    PowerShell by default). The snippet file location is determined by the
    $env:SNIPPETS_HOME environment variable, or defaults to ~/.snippets.json if not set.
    
    .PARAMETER Name
    The name or partial name of snippets to export. Supports wildcard matching.
    If not specified, all snippets will be exported.
    
    .PARAMETER OutputPath
    The directory path where script files should be created. Defaults to the
    current directory. The directory will be created if it doesn't exist.
    
    .PARAMETER Force
    Overwrites existing files without prompting.
    
    .PARAMETER IncludeDescription
    Adds the snippet description as a comment at the top of the exported file.
    
    .EXAMPLE
    Export-Snippet -Name "Profile" -OutputPath ~/scripts
    Exports all snippets with "Profile" in the name to ~/scripts directory.
    
    .EXAMPLE
    Export-Snippet -OutputPath ~/scripts -IncludeDescription
    Exports all snippets to ~/scripts with descriptions as comments.
    
    .EXAMPLE
    Get-Snippet "Test" | Export-Snippet -OutputPath ./exports -Force
    Exports a specific snippet using pipeline input, overwriting if exists.
    
    .EXAMPLE
    Export-Snippet -Name "Reload" -OutputPath . -IncludeDescription
    Exports matching snippets to current directory with descriptions.
    
    .INPUTS
    System.String, System.Management.Automation.PSCustomObject
    Accepts snippet names or objects with a Name property from the pipeline.

    .OUTPUTS
    System.IO.FileInfo
    Returns file info objects for each exported script file.
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,
        [Parameter()]
        [string]$OutputPath = '.',
        [Parameter()]
        [switch]$Force,
        [Parameter()]
        [switch]$IncludeDescription
    )
    
    begin {
        # Ensure output directory exists
        if (-not (Test-Path $OutputPath)) {
            New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
            Write-Verbose "Created output directory: $OutputPath"
        }
        
        $snippetFile = if ($env:SNIPPETS_HOME) { $env:SNIPPETS_HOME } else { Join-Path -Path $HOME -ChildPath '.snippets.json' }
        $snippets = Get-Content $snippetFile | ConvertFrom-Json
    }
    
    process {
        # Get matching snippets
        if ($Name) {
            $matchingSnippets = $snippets.snippets | Where-Object { $_.name -like "*$Name*" }
        } else {
            $matchingSnippets = $snippets.snippets
        }
        
        if (-not $matchingSnippets) {
            Write-Warning "No snippets found matching '$Name'."
            return
        }
        
        foreach ($snippet in $matchingSnippets) {
            # Determine file extension based on language
            $extension = switch ($snippet.language) {
                'powershell' { '.ps1' }
                'python' { '.py' }
                'bash' { '.sh' }
                'javascript' { '.js' }
                'typescript' { '.ts' }
                default { '.ps1' }
            }
            
            # Sanitize filename (remove invalid characters)
            $fileName = $snippet.name -replace '[\\\/:*?"<>|]', '_'
            $filePath = Join-Path -Path $OutputPath -ChildPath "$fileName$extension"
            
            # Check if file exists
            if ((Test-Path $filePath) -and -not $Force) {
                Write-Warning "File already exists: $filePath. Use -Force to overwrite."
                continue
            }
            
            # Build file content
            $content = ''
            if ($IncludeDescription -and $snippet.description) {
                $content += "# $($snippet.description)`n`n"
            }
            $content += $snippet.code
            
            # Write to file
            Set-Content -Path $filePath -Value $content -Force
            Write-Host "Exported snippet '$($snippet.name)' to: $filePath" -ForegroundColor Green
            
            # Return file info
            Get-Item $filePath
        }
    }
}

function Export-SnippetToMarkdown {
    <#
    .SYNOPSIS
    Exports snippets to MultiMarkdown format.
    
    .DESCRIPTION
    Reads snippets from the snippet library and generates a MultiMarkdown document
    with properly formatted code blocks including language syntax highlighting.
    Snippets are organized by their primary tag.
    
    .PARAMETER OutputPath
    The path where the markdown file should be saved. Defaults to './snippets.md'
    
    .PARAMETER Title
    The title for the markdown document. Defaults to 'Code Snippets'
    
    .EXAMPLE
    Export-SnippetToMarkdown -OutputPath ~/Documents/snippets.md
    Exports all snippets to a markdown file in the Documents folder.
    
    .EXAMPLE
    Export-SnippetToMarkdown -Title "My PowerShell Snippets" -OutputPath ./my-snippets.md
    Exports snippets with a custom title.
    
    .INPUTS
    None

    .OUTPUTS
    System.IO.FileInfo
    Returns the file info for the created markdown file.
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$OutputPath = './snippets.md',
        [Parameter()]
        [string]$Title = 'Code Snippets'
    )
    
    # Get all snippets using existing cmdlet
    $allSnippets = Get-Snippet
    
    if (-not $allSnippets) {
        Write-Warning 'No snippets found to export.'
        return
    }
    
    # Start building markdown
    $markdown = @()
    $markdown += "Title: $Title"
    $markdown += "Date: $(Get-Date -Format 'yyyy-MM-dd')"
    $markdown += ''
    $markdown += "# $Title"
    $markdown += ''
    
    # Group snippets by primary tag
    $tagGroups = $allSnippets | Group-Object -Property { 
        if ($_.Tags -and $_.Tags.Count -gt 0) { $_.Tags[0] } else { 'Uncategorized' }
    }
    
    # Output snippets by category
    foreach ($group in ($tagGroups | Sort-Object Name)) {
        $markdown += "## $($group.Name.Substring(0,1).ToUpper() + $group.Name.Substring(1))"
        $markdown += ''
        
        foreach ($snippet in ($group.Group | Sort-Object -Property Name)) {
            # Snippet name as heading
            $markdown += "### $($snippet.Name)"
            $markdown += ''
            
            # Description
            $markdown += $snippet.Description
            $markdown += ''
            
            # Tags (if multiple)
            if ($snippet.Tags -and $snippet.Tags.Count -gt 1) {
                $markdown += '**Tags:** ' + ($snippet.Tags -join ', ')
                $markdown += ''
            }
            
            # Code block with language
            $language = if ($snippet.Language) { $snippet.Language } else { 'powershell' }
            $markdown += "``````$language"
            $markdown += $snippet.Code
            $markdown += "``````"
            $markdown += ''
            
            # Created date (optional metadata)
            if ($snippet.Created) {
                $createdDate = [DateTime]::Parse($snippet.Created).ToString('yyyy-MM-dd')
                $markdown += "*Created: $createdDate*"
                $markdown += ''
            }
        }
    }
    
    # Write to file
    $markdown -join "`n" | Set-Content -Path $OutputPath -Encoding UTF8
    
    Write-Host "Snippets exported to: $OutputPath" -ForegroundColor Green
    Write-Host "Total snippets: $($allSnippets.Count)" -ForegroundColor Cyan
    
    # Return file info
    Get-Item $OutputPath
}

Export-ModuleMember -Function Get-Snippet, Invoke-Snippet, New-Snippet, Set-Snippet, Remove-Snippet, Export-Snippet, Export-SnippetToMarkdown
