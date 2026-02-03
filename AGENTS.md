# AGENTS.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

PSSnippets is a PowerShell module for managing code snippets via JSON storage. The project uses a symlink architecture where `1.0.0` symlinks to `~/.config/powershell/Modules/PSSnippets` containing the actual module files (`PSSnippets.psm1` and `PSSnippets.psd1`).

## Key Architecture

### Module Structure
- **Active module files**: Located at `~/.config/powershell/Modules/PSSnippets/` (symlinked from repo via `1.0.0/`)
- **Test files**: Located in `Tests/` directory within the repository
- **Documentation**: Jekyll-based GitHub Pages site in `docs/` directory

### Snippet Storage
- Default location: `~/.snippets.json` 
- Override via: `$env:SNIPPETS_HOME` environment variable
- Format: JSON object with `snippets` array containing objects with `name`, `description`, `code`, `language`, `tags`, and `created` (ISO-8601 timestamp) fields

### Module Functions
All seven exported functions follow the same pattern:
1. Resolve snippet file path from `$env:SNIPPETS_HOME` or default
2. Load and parse JSON
3. Perform operation (filter, modify, execute, export)
4. Save changes back to JSON (for write operations)

## Development Commands

### Testing
```powershell
# Run all Pester tests
Invoke-Pester -Path ./Tests/PSSnippets.Tests.ps1

# Run specific test context
Invoke-Pester -Path ./Tests/PSSnippets.Tests.ps1 -Tag 'Get-Snippet'

# Run tests with detailed output
Invoke-Pester -Path ./Tests/PSSnippets.Tests.ps1 -Output Detailed
```

### Module Development
```powershell
# Import module from development location
Import-Module ~/.config/powershell/Modules/PSSnippets/PSSnippets.psd1 -Force

# Reload after making changes
Remove-Module PSSnippets -ErrorAction SilentlyContinue
Import-Module ~/.config/powershell/Modules/PSSnippets/PSSnippets.psd1 -Force
```

### Documentation Site (Jekyll)
```bash
# Navigate to docs directory
cd docs

# Install dependencies (uses Ruby 3.2.10 via .ruby-version)
bundle install

# Build site locally
bundle exec jekyll build

# Serve site locally with live reload
bundle exec jekyll serve --livereload

# Build for production
bundle exec jekyll build --config _config.yml
```

## Ruby Environment

This project uses **Ruby 3.2.10** for Jekyll documentation builds (specified in `.ruby-version`). A custom `cd` function in `~/.zshrc` automatically switches to the Homebrew-installed Ruby 3.2 when entering the project directory.

The GitHub Actions workflow (`.github/workflows/pages.yml`) explicitly configures Ruby 3.2 with bundler caching to match the local development environment.

## Testing Patterns

Tests use temporary JSON files with `$env:SNIPPETS_HOME` override to isolate each test run. Key patterns:
- `Initialize-TestSnippetStore`: Creates temporary snippet store
- `BeforeEach`: Sets up fresh temp file and overrides `$env:SNIPPETS_HOME`
- `AfterEach`: Cleans up temp file and restores previous environment

Tests validate both function output and file system state (JSON content).

## Module Manifest Notes

- `PowerShellVersion = '5.1'` in manifest but README specifies PowerShell 7.0+ requirement
- Module path resolution assumes symlink from `1.0.0/` to `~/.config/powershell/Modules/PSSnippets/`
- All changes to module code must be made in `~/.config/powershell/Modules/PSSnippets/` (the symlink target)
