$ErrorActionPreference = "Stop" # Stop to executing program when error is occured
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

##############################
# winget setup
##############################
# If you don't have winget, Manually install winget on $Env:USERPROFILE\Downloads Folder.
# See also : https://zenn.dev/nobokko/articles/idea_winget_wsb#windows%E3%82%B5%E3%83%B3%E3%83%89%E3%83%9C%E3%83%83%E3%82%AF%E3%82%B9%E3%81%ABwinget%E3%82%92%E5%B0%8E%E5%85%A5%E3%81%97%E3%82%88%E3%81%86%EF%BC%81%E3%81%A8%E3%81%84%E3%81%86%E8%A9%B1
$ProgressPreference = 'SilentlyContinue'
$winget = "winget"
if ( -not ( Get-Command $winget -ErrorAction "silentlycontinue" ) ) {
    Write-Host "winget command does not exist.`n Try to install winget manually using invoke-webrequest and Add-AppxPackage!"
    $install_path = "$Env:USERPROFILE\Downloads\winget-cli-install-temp"
    mkdir -p $install_path
    Invoke-WebRequest -Uri https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6 -outfile $install_path\microsoft.ui.xaml.2.8.6.zip -UseBasicParsing
    Write-Host "Downloaded Microsoft.UI.Xaml.2.8.6.zip"
    invoke-webrequest -uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -outfile $install_path\Microsoft.VCLibs.x64.14.00.Desktop.appx -UseBasicParsing
    Write-Host "Downloaded Microsoft.VCLibs.x64.14.00.Desktop.appx"
    # Get the latest version URL of winget-cli from the release page to download_url variable.
    $browser_download_urls = Invoke-RestMethod https://api.github.com/repos/microsoft/winget-cli/releases/latest  | Select-Object -ExpandProperty assets | Select-Object -ExpandProperty browser_download_url
    $download_url_msixbundle = $browser_download_urls | Where-Object { $_ -like "*Microsoft.DesktopAppInstaller*.msixbundle" }
    $download_url_license = $browser_download_urls | Where-Object { $_ -like "*_License*.xml" }
    # Download the latest version of winget-cli
    Invoke-WebRequest -uri $download_url_msixbundle -UseBasicParsing -outfile $install_path\Microsoft.DesktopAppInstaller.msixbundle
    Invoke-WebRequest -uri $download_url_license -UseBasicParsing -outfile $install_path\Microsoft.DesktopAppInstaller_License.xml
    Write-Host "Downloaded Microsoft.DesktopAppInstaller.msixbundle and Microsoft.DesktopAppInstaller_License.xml"
    Expand-Archive -Path  $install_path\microsoft.ui.xaml.2.8.6.zip -DestinationPath  $install_path\microsoft.ui.xaml.2.8.6
    Add-AppxPackage -Path $install_path\microsoft.ui.xaml.2.8.6\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.8.appx
    Write-Host "Installed Microsoft.UI.Xaml.2.8.appx"
    Add-AppxPackage -Path $install_path\Microsoft.VCLibs.x64.14.00.Desktop.appx
    Write-Host "Installed Microsoft.VCLibs.x64.14.00.Desktop.appx"
    Add-AppxProvisionedPackage -Online -PackagePath $install_path\Microsoft.DesktopAppInstaller.msixbundle -LicensePath $install_path\Microsoft.DesktopAppInstaller_License.xml
    Add-AppxPackage -Path $install_path\Microsoft.DesktopAppInstaller.msixbundle
    Write-Host "Installed Microsoft.DesktopAppInstaller.msixbundle"
    Write-Host "winget command is successfully installed!"
    rm -r $install_path
}

##############################
# Install softwares (windows)
##############################

# WindowsTerminal (https://www.microsoft.com/ja-jp/p/windows-terminal/9n0dx20hk701)
# is a powerful terminal software. I recommend you to use this software when you use WSL2 ubuntu.
winget install --silent Microsoft.WindowsTerminal --accept-package-agreements --accept-source-agreements

# Vscode (https://code.visualstudio.com/)
# is a very powerful editor. I strongly suggest you to use this editor when you edit any text files.
# (Install option reference is here : https://proudust.github.io/20200726-winget-install-vscode/)
winget install --silent Microsoft.VisualStudioCode --override "/VERYSILENT /NORESTART /mergetasks=""!runcode,desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"""

# You can extract tar.gz etc. files by using 7zip (https://sevenzip.osdn.jp/).
winget install --silent 7zip.7zip

# Winscp (https://winscp.net/eng/docs/lang:jp)
# provides you to download/upload files with calculation servers by using scp (or sftp) protocol.
winget install --silent --scope user WinSCP.WinSCP

# Git (https://gitforwindows.org/) supports git command on windows.
winget install --silent Git.Git

# Teraterm (https://ttssh2.osdn.jp/) is a terminal software.
# If you don't like other terminal softwares, you can use this software.
winget install --silent TeraTermProject.teraterm --override "/VERYSILENT"

# Stream Labs OBS (https://streamlabs.com/) is a streaming software.
winget install --silent Streamlabs.StreamlabsOBS

# Zoom (https://zoom.us/) is a video conference software.
winget install --silent Zoom.Zoom

# PowerToys (https://learn.microsoft.com/ja-jp/windows/powertoys/) is a software that provides you to customize windows.
winget install --silent Microsoft.PowerToys

# Slack (https://slack.com/intl/ja-jp/) is a chat software.
winget install --silent SlackTechnologies.Slack

# Notion (https://www.notion.so/) is a note software.
winget install --silent Notion.Notion

# Kindle (https://www.amazon.co.jp/gp/digital/fiona/kcp-landing-page) is a ebook reader software.
winget install --silent Amazon.Kindle

# Dropbox (https://www.dropbox.com/ja/) is a cloud storage software.
winget install --silent Dropbox.Dropbox

# QuickLook (https://apps.microsoft.com/store/detail/9NV4BS3L1H4S) is a software that provides you to preview files.
winget install --silent QL-Win.QuickLook

##############################
# Windows Terminal setting
##############################

$new_guid=[Guid]::NewGuid()
$git_bash_terminal_setting="{
    `"commandline`": `"%PROGRAMFILES%\\Git\\bin\\bash.exe`",
    `"guid`": `"{$new_guid}`",
    `"hidden`": false,
    `"icon`": `"%PROGRAMFILES%\\Git\\mingw64\\share\\git\\git-for-windows.ico`",
    `"name`": `"Git Bash`",
    `"startingDirectory`": `"%USERPROFILE%`"
}"
echo $git_bash_terminal_setting > ../git_settings.json

# Windows Terminal powershell OSC9;9 cwd (https://github.com/microsoft/terminal/issues/8166)
cat Microsoft.PowerShell_profile.ps1 >> $PROMPT

# Install posh-git module for git auto-completion
Install-Module posh-git -Scope CurrentUser -Force


# Git for windows settings
echo "# generated by Git for Windows
test -f ~/.profile && . ~/.profile
test -f ~/.bashrc && . ~/.bashrc" >> $env:HOME\.bash_profile
echo "function backslash() {
  echo `$1 | sed 's#/#\\#g'
}

function fix-symlinks() {
    if [ ! `$(git rev-parse --is-inside-work-tree) ]; then
      echo `"exit because not a git repository`"
      return 1
    fi
    for link in `$(find . -type l); do
      dest=`$(readlink `$link)
      if [ -d `$link ]; then
        rm `$link
        cmd //c mklink //d `$(backslash `$link) `$(backslash `$dest)
      elif [ -f `$link ]; then
        rm `$link
        cmd //c mklink `$(backslash `$link) `$(backslash `$dest)
      fi
    done
}" >> $env:HOME\.bashrc
