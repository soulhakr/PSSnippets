---
title: PSSnippets
layout: default
description: Portable PowerShell snippets module
---

## PSSnippets - Overview

PSSnippets is a PowerShell 7+ module for collecting, organizing, and reusing handy code snippets directly from your shell. Store each snippet in a portable JSON library, search by name, tags, or language, and execute trusted snippets on-demand.

## Why PSSnippets?

- **Single source** of truth for every snippet you rely on.
- **Portable JSON schema** that works across OSes and sync tools.
- **End-to-end workflow**: create, edit, search, run, and export snippets.
- **Language agnostic** with ISO-8601 timestamps for auditing.

## Installation

```powershell
# Clone the repo
 git clone https://github.com/soulhakr/PSSnippets.git
 cd PSSnippets

# Copy to a PSModulePath location (example shown for macOS/Linux)
 cp -R 1.0.0 ~/Documents/PowerShell/Modules/PSSnippets

# Import the module
 Import-Module PSSnippets -Force
```

Validate that commands are available:

```powershell
Get-Command -Module PSSnippets
```

## Configure Your Snippet Store

- Defaults to `~/.snippets.json`.
- Override with an environment variable:

```powershell
$env:SNIPPETS_HOME = "$HOME/.config/snippets/personal-snippets.json"
```

Each entry follows this schema:

```json
{
  "name": "Reload Profile",
  "description": "Reloads the current PowerShell profile",
  "code": "& $PROFILE",
  "language": "powershell",
  "tags": ["profile", "environment"],
  "created": "2026-01-01T12:00:00.0000000Z"
}
```

## Everyday Commands

```powershell
# Add or update snippets
New-Snippet -Name "List Modules" -Description "List installed modules" -Code "Get-Module -ListAvailable"
Set-Snippet -Name "List Modules" -Description "List every module on disk"

# Discover snippets
Get-Snippet -Name "Profile" -Tags profile,setup

# Run trusted snippets
Invoke-Snippet -Name "Reload Profile"

# Clean up
Remove-Snippet -Name "Experimental Snip"
```

## Exporting

```powershell
# Individual scripts (respects snippet language)
Export-Snippet -Name "Profile" -OutputPath ./exports -IncludeDescription

# MultiMarkdown document
Export-SnippetToMarkdown -Title "Team Snippets" -OutputPath ./snippets.md
```

## Documentation Roadmap

This site is a starting point. Generate per-command help with [PlatyPS](https://github.com/PowerShell/platyPS):

```powershell
Install-Module PlatyPS -Scope CurrentUser
New-MarkdownHelp -Module PSSnippets -OutputFolder docs/cmdlets
```

Link any generated pages from a navigation section in `_config.yml` (see below).

## Need Help?

- Read the [GitHub README](../README.md) for deeper troubleshooting.
- Open an issue on GitHub if you hit a bug or want to request a feature.
