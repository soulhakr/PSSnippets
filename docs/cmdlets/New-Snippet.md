---
external help file: PSSnippets-help.xml
Module Name: PSSnippets
online version:
schema: 2.0.0
---

# New-Snippet

## SYNOPSIS

Creates a new code snippet in the snippet library.

## SYNTAX

```powershell
New-Snippet [-Name] <String> [-Description] <String> [-Code] <String> [[-Language] <String>]
 [[-Tags] <String[]>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Adds a new snippet with the specified name, description, and code to the
snippet library.
The snippet name must be unique.
The snippet file location
is determined by the $env:SNIPPETS_HOME environment variable, or defaults to
~/.snippets.json if not set.

## EXAMPLES

### EXAMPLE 1

```powershell
New-Snippet -Name "List Files" -Description "List all files" -Code "Get-ChildItem"
Creates a new snippet with the specified properties.
```

### EXAMPLE 2

```powershell
[PSCustomObject]@{Name="Test"; Description="Test snippet"; Code="Write-Host 'test'"} | New-Snippet
Creates a snippet using pipeline input.
```

## PARAMETERS

### -Name

The unique name for the snippet.
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

### -Description

A description of what the snippet does.
This parameter is mandatory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Code

The code content of the snippet.
This parameter is mandatory.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
Position: 4
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
Position: 5
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

### System.String, System.Management.Automation.PSCustomObject

### Accepts snippet definitions from the pipeline when properties match the parameter set

## OUTPUTS

### None

### Writes progress and warnings to the host only

## NOTES

If a snippet with the same name already exists, a warning is displayed and
no changes are made.

## RELATED LINKS
