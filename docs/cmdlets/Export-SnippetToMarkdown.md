---
external help file: PSSnippets-help.xml
Module Name: PSSnippets
online version:
schema: 2.0.0
---

# Export-SnippetToMarkdown

## SYNOPSIS

Exports snippets to MultiMarkdown format.

## SYNTAX

```powershell
Export-SnippetToMarkdown [[-OutputPath] <String>] [[-Title] <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION

Reads snippets from the snippet library and generates a MultiMarkdown document
with properly formatted code blocks including language syntax highlighting.
Snippets are organized by their primary tag.

## EXAMPLES

### EXAMPLE 1

```powershell
Export-SnippetToMarkdown -OutputPath ~/Documents/snippets.md
Exports all snippets to a markdown file in the Documents folder.
```

### EXAMPLE 2

```powershell
Export-SnippetToMarkdown -Title "My PowerShell Snippets" -OutputPath ./my-snippets.md
Exports snippets with a custom title.
```

## PARAMETERS

### -OutputPath

The path where the markdown file should be saved.
Defaults to './snippets.md'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: ./snippets.md
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title

The title for the markdown document.
Defaults to 'Code Snippets'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Code Snippets
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

### None

## OUTPUTS

### System.IO.FileInfo

### Returns the file info for the created markdown file

## NOTES

## RELATED LINKS
