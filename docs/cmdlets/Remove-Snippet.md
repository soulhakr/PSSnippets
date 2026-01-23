---
external help file: PSSnippets-help.xml
Module Name: PSSnippets
online version:
schema: 2.0.0
---

# Remove-Snippet

## SYNOPSIS

Removes a code snippet from the snippet library.

## SYNTAX

```powershell
Remove-Snippet [-Name] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Deletes a snippet by name from the snippet library.
The snippet file location
is determined by the $env:SNIPPETS_HOME environment variable, or defaults to
~/.snippets.json if not set.

## EXAMPLES

### EXAMPLE 1

```powershell
Remove-Snippet -Name "Old Snippet"
Removes the snippet named "Old Snippet".
```

### EXAMPLE 2

```powershell
"Temporary Snippet" | Remove-Snippet
Removes a snippet using pipeline input.
```

### EXAMPLE 3

```powershell
Get-Snippet "Test" | Remove-Snippet
Finds and removes a snippet using pipeline.
```

## PARAMETERS

### -Name

The exact name of the snippet to remove.
This parameter is mandatory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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

### None

### Writes warning or confirmation messages to the host only

## NOTES

If the snippet is not found, a warning is displayed and no changes are made.

## RELATED LINKS
