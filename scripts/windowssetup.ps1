$ErrorActionPreference = "Stop" # Stop to executing program when error is occured

# run setup-wsl.ps1 and winget.ps1
Write-Host "Start running setup-wsl.ps1"
powershell -File $PSScriptRoot\setup-wsl.ps1
Write-Host "Finish running setup-wsl.ps1"
Write-Host "Start running winget.ps1"
powershell -File $PSScriptRoot\winget.ps1
Write-Host "Finish running winget.ps1"
