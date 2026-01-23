---
external help file: PSSnippets-help.xml
Module Name: PSSnippets
online version:
schema: 2.0.0
---

# Set-Snippet

## SYNOPSIS

Updates an existing code snippet in the snippet library.

## SYNTAX

```powershell
Set-Snippet [-Name] <String> [[-NewName] <String>] [[-Description] <String>] [[-Code] <String>]
 [[-Language] <String>] [[-Tags] <String[]>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Modifies properties of an existing snippet including its name, description,
and code.
Only the properties that are specified will be updated.
The snippet
file location is determined by the $env:SNIPPETS_HOME environment variable,
or defaults to ~/.snippets.json if not set.

## EXAMPLES

### EXAMPLE 1

```powershell
Set-Snippet -Name "Old Name" -NewName "New Name"
Renames a snippet.
```

### EXAMPLE 2

```powershell
Set-Snippet -Name "Test" -Description "Updated description" -Code "New code"
Updates the description and code of a snippet.
```

### EXAMPLE 3

```powershell
Get-Snippet "Test" | Set-Snippet -Description "New description"
Updates a snippet using pipeline input.
```

## PARAMETERS

### -Name

The current name of the snippet to update.
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

### -NewName

The new name for the snippet.
If specified, validates that the new name
doesn't conflict with existing snippets.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Description

The new description for the snippet.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Code

The new code content for the snippet.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
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
Position: 5
Default value: Powershell
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Tags

Optional tags to categorize the snippet.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: @()
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProgressAction

{{ Fill ProgressAction Description }}

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

### Writes status messages to the host only

## NOTES

If the snippet is not found or the new name conflicts with an existing
snippet, a warning is displayed and no changes are made.

## RELATED LINKS
