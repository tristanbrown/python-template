Param(
  [string]$RemoteName = "agent-instructions",
  [string]$PrefixDir = ".agents",
  [string]$Branch = "main"
)

set -e

git fetch $RemoteName
git subtree pull --prefix=$PrefixDir $RemoteName $Branch --squash

Write-Host "Agents subtree updated in $PrefixDir from $RemoteName/$Branch."

