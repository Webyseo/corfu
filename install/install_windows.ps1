param(
    [ValidateSet("codex", "claude")]
    [string]$Tool = "claude",

    [ValidateSet("user", "project")]
    [string]$Scope = "user",

    [string]$ProjectPath = ".",

    [switch]$DryRun,

    [switch]$Help
)

function Show-Help {
    Write-Host "Usage: .\install\install_windows.ps1 [-Tool codex|claude] [-Scope user|project] [-ProjectPath <path>] [-DryRun]"
    Write-Host ""
    Write-Host "Install Corfu for Codex or Claude Code without deleting existing destination directories."
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\install\install_windows.ps1 -Tool codex -Scope user"
    Write-Host "  .\install\install_windows.ps1 -Tool claude -Scope project -ProjectPath C:\path\to\repo"
}

if ($Help) {
    Show-Help
    exit 0
}

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PackageRoot = (Resolve-Path (Join-Path $ScriptDir "..")).Path
$VersionFile = Join-Path $PackageRoot "VERSION"
$Version = "unknown"
if (Test-Path $VersionFile) {
    $Version = (Get-Content $VersionFile -Raw).Trim()
}

if ($Scope -eq "project" -and -not (Test-Path $ProjectPath)) {
    throw "Project path does not exist: $ProjectPath"
}

if ($Tool -eq "codex") {
    $Source = Join-Path $PackageRoot "codex\corfu"
    if ($Scope -eq "user") {
        $Dest = Join-Path $HOME ".agents\skills\corfu"
    } else {
        $Repo = (Resolve-Path $ProjectPath).Path
        $Dest = Join-Path $Repo ".agents\skills\corfu"
    }
    $Command = '$corfu'
} else {
    $Source = Join-Path $PackageRoot "claude\corfu"
    if ($Scope -eq "user") {
        $Dest = Join-Path $HOME ".claude\skills\corfu"
    } else {
        $Repo = (Resolve-Path $ProjectPath).Path
        $Dest = Join-Path $Repo ".claude\skills\corfu"
    }
    $Command = '/corfu'
}

$SkillFile = Join-Path $Source "SKILL.md"
$SnapshotFile = Join-Path $Source "scripts\corfu_snapshot.sh"
if (-not (Test-Path $Source)) { throw "Corfu source directory not found: $Source" }
if (-not (Test-Path $SkillFile)) { throw "Missing source file: $SkillFile" }
if (-not (Test-Path $SnapshotFile)) { throw "Missing source file: $SnapshotFile" }

if ($DryRun) {
    Write-Host "Dry run: would install Corfu $Version at: $Dest"
    Write-Host "Use with: $Command"
    exit 0
}

$Parent = Split-Path -Parent $Dest
New-Item -ItemType Directory -Force -Path $Parent | Out-Null
New-Item -ItemType Directory -Force -Path $Dest | Out-Null
Copy-Item -Recurse -Force (Join-Path $Source "*") $Dest

$InstalledSkill = Join-Path $Dest "SKILL.md"
$InstalledSnapshot = Join-Path $Dest "scripts\corfu_snapshot.sh"
if (-not (Test-Path $InstalledSkill)) { throw "Post-install validation failed: $InstalledSkill missing" }
if (-not (Test-Path $InstalledSnapshot)) { throw "Post-install validation failed: $InstalledSnapshot missing" }

Write-Host "Installed Corfu $Version at: $Dest"
Write-Host "Use with: $Command"
