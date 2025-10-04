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
  Write-Error "Working tree has modifications. Commit or stash changes before updating the agents subtree."
  exit 1
}

git fetch $RemoteName
git subtree pull --prefix=$PrefixDir $RemoteName $Branch --squash

Write-Host "Agents subtree updated in $PrefixDir from $RemoteName/$Branch."
