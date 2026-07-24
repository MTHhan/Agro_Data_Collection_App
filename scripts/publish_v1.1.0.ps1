# Publish Mobile APK v1.1.0 to GitHub Releases + update website links
#
# Prerequisites:
#   1) Install GitHub CLI: winget install --id GitHub.cli
#   2) Login once: gh auth login
#   3) Built APK already at: releases_staging\Agro.Data.apk
#
# Usage (from this repo root):
#   powershell -ExecutionPolicy Bypass -File .\scripts\publish_v1.1.0.ps1

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path (Join-Path $repoRoot "website\index.html"))) {
  $repoRoot = $PSScriptRoot
  if (-not (Test-Path (Join-Path $repoRoot "website\index.html"))) {
    throw "Run this script from Agro_Data_Collection_App repo."
  }
}

Set-Location $repoRoot

$apk = Join-Path $repoRoot "releases_staging\Agro.Data.apk"
if (-not (Test-Path $apk)) {
  throw "Missing APK: $apk`nBuild first: cd ..\ttgyi_data; flutter build apk --release; copy to releases_staging\Agro.Data.apk"
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  throw "GitHub CLI (gh) not found. Install: winget install --id GitHub.cli"
}

$tag = "v_1.1.0"
$title = "Agri Data Collection App $tag"
$notes = @"
## Mobile update $tag

- Ento Sem 8 ကျောင်းသား ID များ ထည့်သွင်းထားပါသည်
- အရင် app ကို uninstall မလုပ်ဘဲ APK အသစ် install လုပ်၍ update နိုင်ပါသည် (versionCode 2)

### Downloads
- Android: ``Agro.Data.apk``
- Windows desktop သည် ယခင် v1.0.0 အတိုင်း ဖြစ်ပါသည်
"@

Write-Host "Creating / updating GitHub Release $tag ..."
$existing = gh release view $tag -R MTHhan/Agro_Data_Collection_App 2>$null
if ($LASTEXITCODE -eq 0) {
  Write-Host "Release $tag already exists — uploading/replacing APK asset..."
  gh release upload $tag $apk -R MTHhan/Agro_Data_Collection_App --clobber
} else {
  gh release create $tag $apk `
    -R MTHhan/Agro_Data_Collection_App `
    --title $title `
    --notes $notes
}

Write-Host ""
Write-Host "Next: commit + push website/README version link changes to main"
Write-Host "  git add website/index.html README.md"
Write-Host "  git commit -m `"Point download site to mobile $tag`""
Write-Host "  git push origin main"
Write-Host ""
Write-Host "Website: https://mthhan.github.io/Agro_Data_Collection_App/"
Write-Host "APK:     https://github.com/MTHhan/Agro_Data_Collection_App/releases/download/$tag/Agro.Data.apk"
