##############################
# winget setup
##############################
# If you don't have winget, Manually install winget on $Env:USERPROFILE\Downloads Folder.
# See also : https://zenn.dev/nobokko/articles/idea_winget_wsb#windows%E3%82%B5%E3%83%B3%E3%83%89%E3%83%9C%E3%83%83%E3%82%AF%E3%82%B9%E3%81%ABwinget%E3%82%92%E5%B0%8E%E5%85%A5%E3%81%97%E3%82%88%E3%81%86%EF%BC%81%E3%81%A8%E3%81%84%E3%81%86%E8%A9%B1
$ProgressPreference = 'SilentlyContinue'
$winget = "winget"
if ( -not ( Get-Command $winget -ErrorAction "silentlycontinue" ) ) {
    Write-Host "winget command does not exist.`n Try to install winget manually using invoke-webrequest and Add-AppxPackage!"
    invoke-webrequest -uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -outfile $Env:USERPROFILE\Downloads\Microsoft.VCLibs.x64.14.00.Desktop.appx -UseBasicParsing
    invoke-webrequest -uri https://github.com/microsoft/winget-cli/releases/download/v1.0.12576/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -outfile $Env:USERPROFILE\Downloads\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle -UseBasicParsing
    Add-AppxPackage -Path $Env:USERPROFILE\Downloads\Microsoft.VCLibs.x64.14.00.Desktop.appx
    Add-AppxPackage -Path $Env:USERPROFILE\Downloads\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
}

##############################
# Install softwares (windows)
##############################

winget install --silent CPUID.CPU-Z
winget install --silent TechPowerUp.GPU-Z
winget install --silent Nvidia.GeForceExperience
winget install --silent Guru3D.Afterburner
winget install --silent Elgato.WaveLink
winget install --silent Adobe.Acrobat.Reader.64-bit
winget install --silent GIMP.GIMP
winget install --silent Grammarly.Grammarly
winget install --silent voidtools.Everything.Lite
winget install --silent CrystalDewWorld.CrystalDiskInfo
winget install --silent CrystalDewWorld.CrystalDiskMark
winget install --silent --scope user WinSCP.WinSCP
winget install --silent TeraTermProject.teraterm --override "/VERYSILENT"
winget install --silent Zoom.Zoom
winget install --silent Amazon.Kindle
winget install --silent Dropbox.Dropbox
