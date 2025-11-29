Param(
  [Parameter(Position=0)]
  [string]$Branch = "main",
  [string]$RemoteName = "agent-instructions",
  [string]$RemoteUrl = "git@github.com:tristanbrown/agent-instructions.git",
  [string]$PrefixDir = ".agents"
)

$ErrorActionPreference = 'Stop'

if (Test-Path $PrefixDir) {
  git rm -r $PrefixDir
  if ($LASTEXITCODE -ne 0) {
    throw "Failed to remove existing agents directory at $PrefixDir."
  }

  git diff --cached --quiet
  $hasStagedChanges = $LASTEXITCODE -ne 0
  if ($hasStagedChanges) {
    git commit -m "Remove existing agents subtree"
  }
}

git remote add $RemoteName $RemoteUrl
git fetch $RemoteName
git subtree add --prefix=$PrefixDir $RemoteName $Branch --squash

Write-Host "Agents subtree initialized at $PrefixDir from $RemoteName/$Branch."
