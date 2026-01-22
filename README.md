# PSSnippets

A PowerShell module for collecting, organizing, and reusing your favorite code snippets directly from the command line.

## Features

- Store snippets in a portable JSON library that follows a simple schema.
- Search snippets by name, language, or tags with `Get-Snippet`.
- Execute trusted snippets on demand via `Invoke-Snippet`.
- Create, update, and delete snippets with `New-Snippet`, `Set-Snippet`, and `Remove-Snippet`.
- Export snippets to individual script files (`Export-Snippet`) or a polished MultiMarkdown document (`Export-SnippetToMarkdown`).
- Works with any language and supports tagging plus ISO-8601 timestamps for auditing.

## Requirements

- PowerShell 7.0 or later (Windows, macOS, or Linux).
- Access to a JSON file that stores your snippets (defaults to `~/.snippets.json`).

## Installation

1. Clone or download this repository:

   ```powershell
   git clone https://github.com/soulhakr/PSSnippets.git
   ```

2. Copy the `PSSnippets` folder into a location that is part of `$env:PSModulePath` (for example `~/Documents/PowerShell/Modules`).
3. Import the module:

   ```powershell
   Import-Module PSSnippets -Force
   ```

4. Verify the commands are available:

   ```powershell
   Get-Command -Module PSSnippets
   ```

## Configure Your Snippet Store

- By default the module reads from `~/.snippets.json`.
- Override the location by setting `$env:SNIPPETS_HOME` to another JSON file path:

  ```powershell
  $env:SNIPPETS_HOME = "$HOME/.config/snippets/personal-snippets.json"
  ```

- The file should contain an object with a `snippets` array. Each entry uses the following shape:

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

## Usage

### Create a snippet

```powershell
New-Snippet -Name "List Modules" -Description "List installed modules" -Code "Get-Module -ListAvailable"
```

### Find snippets

```powershell
Get-Snippet -Name "Profile" -Tags profile,setup
```

### Run a snippet

```powershell
Invoke-Snippet -Name "Reload Profile"
```

### Update or remove

```powershell
Set-Snippet -Name "List Modules" -Description "List every module on disk"
Remove-Snippet -Name "Experimental Snip"
```

### Export for sharing

```powershell
# Individual scripts (respects snippet language for extensions)
Export-Snippet -Name "Profile" -OutputPath ./exports -IncludeDescription

# MultiMarkdown document
Export-SnippetToMarkdown -Title "Team Snippets" -OutputPath ./snippets.md
```

## Troubleshooting

- **File not found**: Ensure `~/.snippets.json` exists or set `$env:SNIPPETS_HOME` to a valid file path.
- **Duplicate names**: `New-Snippet` enforces unique names; use `Set-Snippet -NewName` to rename existing entries.
- **Execution policy**: `Invoke-Snippet` uses `Invoke-Expression`; run only trusted snippets.

## Contributing

1. Fork the repository and create a feature branch.
2. Make your changes with clear commits.
3. Add or update tests/examples when applicable.
4. Open a pull request describing the change, rationale, and any considerations.

## License

This project is licensed under the MIT License.
