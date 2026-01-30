# VerzideTweaks online bootstrapper

$repoUrl = "https://github.com/Verzidereal/VerzideTweaks/archive/refs/heads/main.zip"
$installPath = "$env:LOCALAPPDATA\VerzideTweaks"

Write-Host "[+] Downloading VerzideTweaks..."

# Create folder if missing
if (!(Test-Path $installPath)) {
    New-Item -Path $installPath -ItemType Directory | Out-Null
}

# Download zip
$zipPath = "$installPath\VerzideTweaks.zip"
Invoke-WebRequest -Uri $repoUrl -OutFile $zipPath -UseBasicParsing

Write-Host "[+] Extracting files..."

# Extract contents
Expand-Archive -Path $zipPath -DestinationPath $installPath -Force
Remove-Item $zipPath

# The zip extracts into VerzideTweaks-main
$modulePath = "$installPath\VerzideTweaks-main"

Write-Host "[+] Launching VerzideTweaks..."

# Run main launcher
powershell -ExecutionPolicy Bypass -File "$modulePath\main.ps1"
