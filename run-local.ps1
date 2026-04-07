param(
    [ValidateSet('Debug', 'Release', 'Test')]
    [string]$Configuration = 'Debug',

    [ValidateSet('x64', 'x86', 'ARM64')]
    [string]$Platform = 'x64'
)

$ErrorActionPreference = 'Stop'

$repoRoot = $PSScriptRoot
$solutionPath = Join-Path $repoRoot 'epcalipers\epcalipers.sln'
$appOutputDir = Join-Path $repoRoot "epcalipers\EPCalipersWinUI3\bin\$Platform\$Configuration\net9.0-windows10.0.22621.0\win-$($Platform.ToLower())"
$exePath = Join-Path $appOutputDir 'EPCalipersWinUI3.exe'

Write-Host "Building solution: $solutionPath"
dotnet build $solutionPath -c $Configuration -p:Platform=$Platform

if (-not (Test-Path $exePath)) {
    throw "Built executable not found at $exePath"
}

Write-Host "Launching: $exePath"
$process = Start-Process -FilePath $exePath -PassThru
Write-Host "Started EPCalipersWinUI3 with PID $($process.Id)"
