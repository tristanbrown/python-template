Param(
  [string]$RemoteName = "agent-instructions",
  [string]$RemoteUrl = "git@github.com:tristanbrown/agent-instructions.git",
  [string]$PrefixDir = ".agents",
  [string]$Branch = "main"
)

$ErrorActionPreference = 'Stop'

# Ensure remote exists (minimal)
git remote get-url $RemoteName *> $null
if ($LASTEXITCODE -ne 0) {
  git remote add $RemoteName $RemoteUrl
}

git fetch $RemoteName
git subtree pull --prefix=$PrefixDir $RemoteName $Branch --squash

Write-Host "Agents subtree updated in $PrefixDir from $RemoteName/$Branch."
