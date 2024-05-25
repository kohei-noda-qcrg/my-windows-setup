$ErrorActionPreference = "Stop" # Stop to executing program when error is occured

# run setup-wsl.ps1 and setup-windows.ps1
Write-Host "Start running setup-wsl.ps1"
. .\setup-wsl.ps1
Write-Host "Finish running setup-wsl.ps1"
Write-Host "Start running setup-windows.ps1"
. .\setup-windows.ps1
Write-Host "Finish running setup-windows.ps1"
