param(
    [ValidateSet('Debug', 'Release', 'Test')]
    [string]$Configuration = 'Debug',

    [ValidateSet('x64', 'x86', 'ARM64')]
    [string]$Platform = 'x64'
)

$ErrorActionPreference = 'Stop'

$repoRoot = $PSScriptRoot
$appProjectPath = Join-Path $repoRoot 'epcalipers\EPCalipersWinUI3\EPCalipersWinUI3.csproj'
$appOutputDir = Join-Path $repoRoot "epcalipers\EPCalipersWinUI3\bin\$Platform\$Configuration\net9.0-windows10.0.22621.0\win-$($Platform.ToLower())"
$exePath = Join-Path $appOutputDir 'EPCalipersWinUI3.exe'
Get-Process EPCalipersWinUI3 -ErrorAction SilentlyContinue |
    Where-Object { $_.Path -eq $exePath } |
    Stop-Process -Force
Write-Host "Building app project: $appProjectPath"
dotnet build $appProjectPath -c $Configuration -p:Platform=$Platform

if (-not (Test-Path $exePath)) {
    throw "Built executable not found at $exePath"
}

Write-Host "Launching: $exePath"
$process = Start-Process -FilePath $exePath -PassThru
Write-Host "Started EPCalipersWinUI3 with PID $($process.Id)"
