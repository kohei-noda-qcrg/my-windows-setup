$ErrorActionPreference = "Stop" # Stop to executing program when error is occured
$ProgressPreference = 'SilentlyContinue'

#########################
# Install wsl (Ubuntu)
#########################
Function ManuallyInstallWSL2() {
    # Set default WSL version to 2
    wsl --set-default-version 2
    Write-Host "The default version of wsl was set to 2"
    # Install Ubuntu
    Invoke-WebRequest -Uri https://aka.ms/wslubuntu -OutFile linux.appx -UseBasicParsing
    Add-AppxPackage -Path linux.appx
    Remove-Item linux.appx
    Write-Host "Ubuntu installed!"
}

# WSL 2 Kernel Update
Write-Host "Start downloading a wsl2 kernel update file"
Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile wsl_update_x64.msi -UseBasicParsing
Write-Host "Downloaded a wsl2 kernel update file"
msiexec /i wsl_update_x64.msi /passive /norestart
Write-Host "Applied a wsl2 kernel update file"

# Check if wsl command is recognized on your computer (KB5004296 is required)
# See also : https://forest.watch.impress.co.jp/docs/news/1342078.html
$wslcommand = "wsl"
# Check windows version
$version = Get-WmiObject Win32_OperatingSystem | findstr "BuildNumber" # (e.g.) BuildNumber : 19041
$winverlist = $version -split " +"
$winver = $winverlist[-1] # (e.g.) 19041
if ($winver -lt 18362){ # Cannot use wsl under 18362
    Write-Host "================================="
    Write-Host "ERROR: Your windows build version is $winver.`nWSL requires windows build version >= 18362.1049+.`nSo you must upgrade Windows OS at least build 18362(ver.1903).`nIf you want more information, see https://docs.microsoft.com/ja-jp/windows/wsl/install-manual.`nExit."
    Write-Host "================================="
    exit
}
elseif ($winver -lt 19041){ # Cannot use wsl --install command under 19041 https://docs.microsoft.com/ja-jp/windows/wsl/install-manual
    Write-Host "================================="
    Write-Host "Warning: Your windows build version is $winver.`nwsl --install command requires windows build version >= 19041.`nTo get Ubuntu, run manually install commands.`nAfter install Ubuntu you must launch Ubuntu on your own."
    Write-Host "================================="
    ManuallyInstallWSL2
}else{ # Can use wsl --install command >= 19041 https://docs.microsoft.com/ja-jp/windows/wsl/install-manual
    try {
        if (Get-Command $wslcommand) {
            Write-Host "$wslcommand already exists! try to install Ubuntu using $wslcommand command."
            wsl --install -d Ubuntu
        }
        else {
            Write-Host "$command does not exist. To use $command command, Install dependencies."
            ManuallyInstallWSL2
        }
    }
    catch {
        Write-Host "catch err."
        ManuallyInstallWSL2
    }
}

# enable dns tunneling (https://learn.microsoft.com/ja-jp/windows/wsl/networking#dns-tunneling)
$wslconfig = "$env:USERPROFILE\.wslconfig"
echo "[wsl2]" >> $wslconfig
echo "dnsTunneling=true" >> $wslconfig
