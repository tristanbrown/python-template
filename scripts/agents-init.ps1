Param(
  [string]$RemoteName = "agent-instructions",
  [string]$RemoteUrl = "git@github.com:tristanbrown/agent-instructions.git",
  [string]$PrefixDir = ".agents",
  [string]$Branch = "main",
  [switch]$UseSsh,
  [switch]$UseHttps,
  [switch]$Force
)

$ErrorActionPreference = 'Stop'

if ($UseHttps.IsPresent -and $PSBoundParameters["RemoteUrl"] -eq $null) {
  $RemoteUrl = "https://github.com/tristanbrown/agent-instructions.git"
}

# Ensure remote exists
$remoteExists = $false
try {
  git remote get-url $RemoteName 2>$null | Out-Null
  if ($LASTEXITCODE -eq 0) { $remoteExists = $true }
} catch {
  $remoteExists = $false
}
if (-not $remoteExists) {
  git remote add $RemoteName $RemoteUrl
} elseif ($Force.IsPresent) {
  git remote set-url $RemoteName $RemoteUrl
}

# Require clean working tree
$status = git status --porcelain
if (-not [string]::IsNullOrWhiteSpace($status)) {
  Write-Error "Working tree has modifications. Commit or stash changes before initializing the agents subtree."
  exit 1
}

# If prefix exists and only contains placeholder README.md, remove it
if (Test-Path -LiteralPath $PrefixDir) {
  $items = Get-ChildItem -LiteralPath $PrefixDir -Force -ErrorAction SilentlyContinue
  $onlyPlaceholder = $items.Count -eq 1 -and $items[0].Name -eq 'README.md'
  if ($onlyPlaceholder) {
    Remove-Item -LiteralPath $PrefixDir -Recurse -Force
  } elseif ($items.Count -gt 0 -and -not $Force) {
    Write-Error "Directory '$PrefixDir' already exists and is not empty. Re-run with -Force to attempt update, or use scripts/agents-update.ps1."
    exit 1
  }
}

git fetch $RemoteName

if (Test-Path -LiteralPath $PrefixDir) {
  # Fallback: if directory exists (e.g., user passed -Force), try pull instead of add
  git subtree pull --prefix=$PrefixDir $RemoteName $Branch --squash
} else {
  git subtree add --prefix=$PrefixDir $RemoteName $Branch --squash
}

Write-Host "Agents subtree initialized/updated at $PrefixDir from $RemoteName/$Branch."
