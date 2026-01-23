---
external help file: PSSnippets-help.xml
Module Name: PSSnippets
online version:
schema: 2.0.0
---

# Export-Snippet

## SYNOPSIS

Exports one or more snippets to individual script files.

## SYNTAX

```powershell
Export-Snippet [[-Name] <String>] [[-OutputPath] <String>] [-Force] [-IncludeDescription]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Retrieves snippets from the library and exports them as individual script files.
The file extension is determined by the snippet's language property (.ps1 for
PowerShell by default).
The snippet file location is determined by the
$env:SNIPPETS_HOME environment variable, or defaults to ~/.snippets.json if not set.

## EXAMPLES

### EXAMPLE 1

```powershell
Export-Snippet -Name "Profile" -OutputPath ~/scripts
Exports all snippets with "Profile" in the name to ~/scripts directory.
```

### EXAMPLE 2

```powershell
Export-Snippet -OutputPath ~/scripts -IncludeDescription
Exports all snippets to ~/scripts with descriptions as comments.
```

### EXAMPLE 3

```powershell
Get-Snippet "Test" | Export-Snippet -OutputPath ./exports -Force
Exports a specific snippet using pipeline input, overwriting if exists.
```

### EXAMPLE 4

```powershell
Export-Snippet -Name "Reload" -OutputPath . -IncludeDescription
Exports matching snippets to current directory with descriptions.
```

## PARAMETERS

### -Name

The name or partial name of snippets to export.
Supports wildcard matching.
If not specified, all snippets will be exported.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -OutputPath

The directory path where script files should be created.
Defaults to the
current directory.
The directory will be created if it doesn't exist.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: .
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Overwrites existing files without prompting.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeDescription

Adds the snippet description as a comment at the top of the exported file.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction

Controls how PowerShell responds to progress records emitted by this cmdlet (for example, output from Write-Progress). Added in PowerShell 7.4. See [-ProgressAction at Microsoft Learn](https://learn.microsoft.com/powershell/scripting/developer/cmdlet/common-parameter-names?view=powershell-7.5#progressaction-alias-proga) for accepted values.

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String, System.Management.Automation.PSCustomObject

### Accepts snippet names or objects with a Name property from the pipeline

## OUTPUTS

### System.IO.FileInfo

### Returns file info objects for each exported script file

## NOTES

## RELATED LINKS
