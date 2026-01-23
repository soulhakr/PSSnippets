---
external help file: PSSnippets-help.xml
Module Name: PSSnippets
online version:
schema: 2.0.0
---

# Get-Snippet

## SYNOPSIS

Retrieves code snippets from the snippet library.

## SYNTAX

```powershell
Get-Snippet [[-Name] <String>] [[-Language] <String>] [[-Tags] <String[]>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION

Searches for and returns code snippets that match the specified name pattern.
Uses wildcard matching on the snippet name.
The snippet file location is
determined by the $env:SNIPPETS_HOME environment variable, or defaults to
~/.snippets.json if not set.

## EXAMPLES

### EXAMPLE 1

```powershell
Get-Snippet -Name "Profile"
Retrieves all snippets with "Profile" in the name.
```

Controls how PowerShell responds to progress records emitted by this cmdlet (for example, output from Write-Progress). Added in PowerShell 7.4. See [-ProgressAction at Microsoft Learn](https://learn.microsoft.com/powershell/scripting/developer/cmdlet/common-parameter-names?view=powershell-7.5#progressaction-alias-proga) for accepted values.

```powershell
"Reload" | Get-Snippet
Retrieves snippets using pipeline input.
```

## PARAMETERS

### -Name

The name or partial name of the snippet to retrieve.
Supports wildcard matching.

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

### -Language

The programming language of the snippet.
Defaults to 'powershell'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Powershell
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tags

Optional tags to filter snippets by.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: @()
Accept pipeline input: True (ByPropertyName)
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

### System.String

### Accepts snippet names or objects with a Name property from the pipeline

## OUTPUTS

### PSCustomObject

### Returns snippet objects with name, description, and code properties

## NOTES

## RELATED LINKS
