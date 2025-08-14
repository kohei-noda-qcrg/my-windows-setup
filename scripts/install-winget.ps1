if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "winget command already exists."
}
else {
    Write-Host "winget command does not exist. Trying to install winget manually..."
    Invoke-RestMethod https://github.com/asheroto/winget-install/releases/latest/download/winget-install.ps1 | Invoke-Expression
}