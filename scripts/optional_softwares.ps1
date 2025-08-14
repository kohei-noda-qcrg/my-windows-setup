##############################
# Install optional softwares
##############################
powershell.exe "$PSScriptRoot\install-winget.ps1"

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
winget install --silent Notion.Notion
winget install --silent SlackTechnologies.Slack
winget install --silent Streamlabs.StreamlabsOBS
