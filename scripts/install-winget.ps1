if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "winget command already exists."
} else {
    Write-Host "winget command does not exist. Trying to install winget manually..."
    $ProgressPreference = 'SilentlyContinue'
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Repair-WinGetPackageManager -AllUsers
    Write-Host "winget command installed successfully."
}