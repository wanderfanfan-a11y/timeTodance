[CmdletBinding()]
param(
    [string]$Version,
    [switch]$SkipBuild
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$pubspecPath = Join-Path $root "pubspec.yaml"
$versionLine = Get-Content $pubspecPath |
    Where-Object { $_ -match "^\s*version:" } |
    Select-Object -First 1

if ($versionLine -match "^\s*version:\s*(?<name>\d+\.\d+\.\d+)(?:\+(?<build>\d+))?\s*$") {
    $pubspecVersion = $Matches.name
    $buildNumber = if ($Matches.build) { $Matches.build } else { "1" }
} else {
    throw "Unable to read a semantic version from pubspec.yaml."
}

if (-not $Version) {
    $Version = $pubspecVersion
}

if ($Version -notmatch "^\d+\.\d+\.\d+$") {
    throw "Version must use major.minor.patch format."
}

Push-Location $root
try {
    if (-not $SkipBuild) {
        & flutter build windows --release `
            --build-name $Version `
            --build-number $buildNumber
        if ($LASTEXITCODE -ne 0) {
            throw "Flutter Windows build failed."
        }
    }

    $releaseDir = Join-Path $root "build\windows\x64\runner\Release"
    $executable = Join-Path $releaseDir "tdance.exe"
    if (-not (Test-Path $executable)) {
        throw "Windows release bundle not found at $releaseDir."
    }

    $distDir = Join-Path $root "dist"
    if (Test-Path $distDir) {
        Remove-Item $distDir -Recurse -Force
    }
    New-Item $distDir -ItemType Directory | Out-Null

    $portablePath = Join-Path $distDir "tdance-windows-portable-$Version.zip"
    Compress-Archive `
        -Path (Join-Path $releaseDir "*") `
        -DestinationPath $portablePath `
        -CompressionLevel Optimal

    $isccCommand = Get-Command "ISCC.exe" -ErrorAction SilentlyContinue
    $isccPath = if ($isccCommand) {
        $isccCommand.Source
    } else {
        @(
            "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
            "$env:ProgramFiles\Inno Setup 6\ISCC.exe"
        ) | Where-Object { Test-Path $_ } | Select-Object -First 1
    }
    if (-not $isccPath) {
        throw "Inno Setup 6 was not found."
    }

    $installerScript = Join-Path $root "windows\installer\tdance.iss"
    & $isccPath `
        "/DAppVersion=$Version" `
        "/DSourceDir=$releaseDir" `
        "/DOutputDir=$distDir" `
        $installerScript
    if ($LASTEXITCODE -ne 0) {
        throw "Inno Setup compilation failed."
    }

    $installerPath = Join-Path $distDir "tdance-windows-setup-$Version.exe"
    if (-not (Test-Path $installerPath)) {
        throw "Installer was not created at $installerPath."
    }

    $checksums = @($portablePath, $installerPath) | ForEach-Object {
        $hash = Get-FileHash $_ -Algorithm SHA256
        "$($hash.Hash.ToLowerInvariant())  $(Split-Path $_ -Leaf)"
    }
    Set-Content `
        -Path (Join-Path $distDir "SHA256SUMS.txt") `
        -Value $checksums `
        -Encoding ascii

    Write-Host "Created Windows release packages in $distDir"
    Get-ChildItem $distDir | Select-Object Name, Length
} finally {
    Pop-Location
}
