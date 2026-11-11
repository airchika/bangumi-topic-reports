param(
    [string]$SourcePath = (Join-Path $PSScriptRoot '../reports/anime-timeline-ranking.html')
)
$ErrorActionPreference = 'Stop'
$sourceFile = Get-Item -LiteralPath $SourcePath
if ($sourceFile.PSIsContainer) { throw 'SourcePath must be an HTML file.' }
$destination = Join-Path $PSScriptRoot 'public/index.html'
New-Item -ItemType Directory -Path (Split-Path $destination -Parent) -Force | Out-Null
Copy-Item -LiteralPath $sourceFile.FullName -Destination $destination -Force
if ((Get-FileHash -LiteralPath $sourceFile.FullName).Hash -ne (Get-FileHash -LiteralPath $destination).Hash) {
    throw 'Copied report does not match the source file.'
}
Write-Output "Report copied to $destination"
Write-Output 'Review git diff, then commit and push to publish through Cloudflare.'
