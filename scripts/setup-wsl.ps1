$ErrorActionPreference = "Stop" # Stop to executing program when error is occured
$ProgressPreference = 'SilentlyContinue'

$minwslver = 18362 # Minimum Windows version that supports WSL2


if ($args.Count -lt 1) {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <archlinux|ubuntu>"
    exit 1
}
$distro = $args[0].ToLower()

$winver = [int](Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuildNumber
if ($winver -lt $minwslver) {
    Write-Error "error: your windows build version is $winver.`nWSL requires windows build version >= $minwslver.`nyou must upgrade Windows OS at least build $minwslver."
    exit 1
}

# Install latest WSL
powershell.exe "$PSScriptRoot\install-winget.ps1"
winget install --silent Microsoft.WSL --accept-package-agreements --accept-source-agreements

# disto needs to be one of 'archlinux' or 'ubuntu'
if ($distro -in @('archlinux', 'ubuntu')) {
    Write-Host "Installing WSL distribution: $distro"
    wsl --install -d $distro
} else {
    Write-Error "Unknown distribution: $distro. Supported distributions: archlinux, ubuntu"
    exit 1
}

# enable dns tunneling (https://learn.microsoft.com/ja-jp/windows/wsl/networking#dns-tunneling)
$wslconfig = "$env:USERPROFILE\.wslconfig"
Write-Output "[wsl2]" >> $wslconfig
Write-Output "dnsTunneling=true" >> $wslconfig

Write-Host "WSL distribution $distro installed successfully."
