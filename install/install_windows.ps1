param(
    [ValidateSet("codex", "claude")]
    [string]$Tool = "claude",

    [ValidateSet("user", "project")]
    [string]$Scope = "user",

    [string]$ProjectPath = "."
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PackageRoot = Resolve-Path (Join-Path $ScriptDir "..")

if ($Tool -eq "codex") {
    $Source = Join-Path $PackageRoot "codex\corfu"
    if ($Scope -eq "user") {
        $Dest = Join-Path $HOME ".agents\skills\corfu"
    } else {
        $Repo = Resolve-Path $ProjectPath
        $Dest = Join-Path $Repo ".agents\skills\corfu"
    }
    $Command = '$corfu'
} else {
    $Source = Join-Path $PackageRoot "claude\corfu"
    if ($Scope -eq "user") {
        $Dest = Join-Path $HOME ".claude\skills\corfu"
    } else {
        $Repo = Resolve-Path $ProjectPath
        $Dest = Join-Path $Repo ".claude\skills\corfu"
    }
    $Command = '/corfu'
}

$Parent = Split-Path -Parent $Dest
New-Item -ItemType Directory -Force -Path $Parent | Out-Null
New-Item -ItemType Directory -Force -Path $Dest | Out-Null
Copy-Item -Recurse -Force (Join-Path $Source "*") $Dest

Write-Host "Installed Corfu at: $Dest"
Write-Host "Use with: $Command"
