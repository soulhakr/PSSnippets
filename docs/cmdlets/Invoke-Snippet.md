---
external help file: PSSnippets-help.xml
Module Name: PSSnippets
online version:
schema: 2.0.0
---

# Invoke-Snippet

## SYNOPSIS

Executes a code snippet from the snippet library.

## SYNTAX

```powershell
Invoke-Snippet [-Name] <String> [[-Language] <String>] [[-Tags] <String[]>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION

Retrieves and executes a snippet by exact name match using Invoke-Expression.
The snippet file location is determined by the $env:SNIPPETS_HOME environment
variable, or defaults to ~/.snippets.json if not set.

## EXAMPLES

### EXAMPLE 1

```powershell
Invoke-Snippet -Name "Reload Profile"
Executes the snippet named "Reload Profile".
```

### EXAMPLE 2

```powershell
"Show PSModulePath" | Invoke-Snippet
Executes a snippet using pipeline input.
```

## PARAMETERS

### -Name

The exact name of the snippet to execute.
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

### System.String

### Accepts snippet names or objects with a Name property from the pipeline

## OUTPUTS

### System.Object

### Returns whatever the invoked snippet writes to the pipeline

## NOTES

WARNING: This cmdlet uses Invoke-Expression to execute snippet code.
Only run snippets from trusted sources.

## RELATED LINKS
