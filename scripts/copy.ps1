$ErrorActionPreference = "Stop" # Stop to executing program when error is occured

if ($args.Count -lt 1) {
    Write-Host "Usage: $($MyInvocation.MyCommand.Name) <archlinux|ubuntu>"
    exit 1
}

$distro = $args[0].ToLower()
if ($distro -notin @('archlinux', 'ubuntu')) {
    Write-Host "Unknown distribution: $distro"
    Write-Host "Supported distributions: archlinux, ubuntu"
    exit 1
}

wsl -d $distro bash -c "mkdir -p ~ && exit"
$source = Join-Path $PSScriptRoot $distro
$drive = (Get-Item $source).PSDrive.Name.ToLower()
$wslSource = "/mnt/$drive" + ($source.Substring(2) -replace "\\", "/")
wsl -d $distro bash -c "cp -r '$wslSource/'* ~/"