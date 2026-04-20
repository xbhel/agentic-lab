<#
Usage: .\load-skills.ps1 [-SourceRoot <path>] [-DestinationRoot <path-or-platform> [...]]

Examples
    .\load-skills.ps1
    .\load-skills.ps1 -DestinationRoot codex,copilot
    .\load-skills.ps1 -SourceRoot .\skills -DestinationRoot "$HOME\custom\skills"
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$SourceRoot = '.\skills',
    [string[]]$DestinationRoot = @('codex')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$platformDestinationRoots = @{
    copilot = Join-Path $HOME '.copilot\skills'
    codex = Join-Path $HOME '.codex\skills'
    cursor = Join-Path $HOME '.cursor\skills'
    claude = Join-Path $HOME '.claude\skills'
    opencode = Join-Path $HOME '.opencode\skills'
}

function Resolve-DestinationRoots {
    param(
        [string[]]$RequestedRoots
    )

    $resolvedRoots = foreach ($requestedRoot in $RequestedRoots) {
        $normalizedRoot = $requestedRoot.Trim()
        if (-not $normalizedRoot) {
            continue
        }

        $platformKey = $normalizedRoot.ToLowerInvariant()
        if ($platformDestinationRoots.ContainsKey($platformKey)) {
            $platformDestinationRoots[$platformKey]
            continue
        }

        $normalizedRoot
    }

    @($resolvedRoots | Sort-Object -Unique)
}

function Sync-DestinationRoot {
    param(
        [string]$ResolvedSourceRoot,
        [hashtable]$SourceMap,
        [string]$ResolvedDestinationRoot
    )

    if (-not (Test-Path -LiteralPath $ResolvedDestinationRoot -PathType Container)) {
        if ($PSCmdlet.ShouldProcess($ResolvedDestinationRoot, 'Create destination directory')) {
            New-Item -ItemType Directory -Path $ResolvedDestinationRoot -Force | Out-Null
        }
    }

    if (-not (Test-Path -LiteralPath $ResolvedDestinationRoot -PathType Container)) {
        Write-Host "Skipped destination root because it does not exist yet: $ResolvedDestinationRoot"
        return
    }

    # Only manage junctions that point into the configured source root.
    $managedJunctions = Get-ChildItem -LiteralPath $ResolvedDestinationRoot -Force |
        Where-Object { $_.LinkType -eq 'Junction' } |
        Where-Object {
            $target = $_.Target -join '; '
            $target.StartsWith($ResolvedSourceRoot, [System.StringComparison]::OrdinalIgnoreCase)
        }

    foreach ($junction in $managedJunctions) {
        if (-not $SourceMap.ContainsKey($junction.Name)) {
            if ($PSCmdlet.ShouldProcess($junction.FullName, 'Remove stale junction')) {
                Remove-Item -LiteralPath $junction.FullName -Force
                Write-Host "Removed stale junction: $($junction.Name)"
            }
        }
    }

    foreach ($entry in $SourceMap.GetEnumerator() | Sort-Object Name) {
        $name = $entry.Key
        $target = $entry.Value
        $linkPath = Join-Path $ResolvedDestinationRoot $name

        if (-not (Test-Path -LiteralPath $linkPath)) {
            if ($PSCmdlet.ShouldProcess($linkPath, "Create junction to $target")) {
                New-Item -ItemType Junction -Path $linkPath -Target $target | Out-Null
                Write-Host "Created junction: $name -> $target"
            }
            continue
        }

        $existingItem = Get-Item -LiteralPath $linkPath -Force
        if ($existingItem.LinkType -eq 'Junction') {
            $existingTarget = $existingItem.Target -join '; '
            if ($existingTarget -ne $target) {
                if ($PSCmdlet.ShouldProcess($linkPath, "Retarget junction to $target")) {
                    Remove-Item -LiteralPath $linkPath -Force
                    New-Item -ItemType Junction -Path $linkPath -Target $target | Out-Null
                    Write-Host "Updated junction: $name -> $target"
                }
            }
            continue
        }

        Write-Warning "Skipped existing non-junction item: $linkPath"
    }
}

if (-not (Test-Path -LiteralPath $SourceRoot -PathType Container)) {
    throw "Source directory does not exist: $SourceRoot"
}

$resolvedSourceRoot = (Resolve-Path -LiteralPath $SourceRoot).Path
$resolvedDestinationRoots = Resolve-DestinationRoots -RequestedRoots $DestinationRoot

$sourceDirectories = Get-ChildItem -LiteralPath $SourceRoot -Directory
$sourceMap = @{}

foreach ($directory in $sourceDirectories) {
    $sourceMap[$directory.Name] = $directory.FullName
}

foreach ($resolvedDestinationRoot in $resolvedDestinationRoots) {
    Sync-DestinationRoot -ResolvedSourceRoot $resolvedSourceRoot -SourceMap $sourceMap -ResolvedDestinationRoot $resolvedDestinationRoot
}
