$ErrorActionPreference = "Stop" # Stop to executing program when error is occured

##################################
# Check whether scripts are exist
##################################

# If even one of the following files does not exist, the script will exit.
$files = @('copy.ps1', 'copyfile.bat', 'do_not_turn_off.pow', 'restore_power_settings.ps1', 'ubuntusoftwareinstall.sh', 'vscodeubuntusetup.sh', 'windowssetup.ps1', "writeubuntusettings.sh")
$files | ForEach-Object {
    if (!(Test-Path -Path $_ -PathType Leaf)) {
        Write-Host "Error: $_ is not exist."
        Write-Host "Exit."
        exit
    }
}
# Check windows version
$version = Get-WmiObject Win32_OperatingSystem | findstr "BuildNumber"
$winverlist = $version -split " +"
$winver = $winverlist[-1]

if ($winver -lt 18362){
    Write-Host "================================="
    Write-Host "ERROR: Your windows build version is $winver.`nWSL requires windows build version >= 18362.`nSo you must upgrade Windows OS at least build 18362(ver.1903).`nExit."
    Write-Host "================================="
    exit
}

######################################
# Power settings
######################################
New-Item -Path $Env:USERPROFILE\power_guid_default_setting -Force -ItemType Directory
Function getGUID($arg = "*") {
    $flag = 0 # If GUID: found, $flag = 1
    $guid = "" # When $flag is 1, get the value of $var divided at that time and set $flag to 0

    # Get powercfg settings text including $arg
    $text = powercfg -list | findstr $arg
    # Split $text
    $split = $text -split " "
    foreach ($var in $split) {
        # Set $guid to $var when $flag = 1
        if ($flag -eq 1) {
            $guid = $var
            $flag = 0
        }
        # If $var="GUID:", set $flag to 1
        if ($var -eq "GUID:") {
            $flag = 1
        }
    }
    if ( $guid -eq "") {
        # Error
        Write-Host "GUID is empty"
        return -1
    }
    else {
        Write-Host "Found GUID"
        return $guid
    }
}
Function cantgetGUIDerr() {
    # Quit powercfg setting
    Write-Host "!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!="
    Write-Host "<ERROR: powercfg settings GUID obtain error>"
    Write-Host "Powercfg setting was stopped because GUID could not be obtained."
    Write-Host "Make sure to manually configure or monitor Windows to prevent it from going to sleep"
    Write-Host "!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!=!="
}
powercfg -list
$defaultsetting = -1
$defaultsetting = getGUID("*")
if ($defaultsetting -ne -1) {
    Write-Host "GUID of Default power setting is $defaultsetting"
    Set-Content "$Env:USERPROFILE\power_guid_default_setting\default_power_setting_guid.txt" $defaultsetting
    Copy-Item ".\do_not_turn_off.pow" "$Env:USERPROFILE\power_guid_default_setting"
    powercfg -import "$Env:USERPROFILE\power_guid_default_setting\do_not_turn_off.pow"
    Remove-Item "$Env:USERPROFILE\power_guid_default_setting\do_not_turn_off.pow"
    powercfg -list
    $do_not_turn_off = -1
    $do_not_turn_off = getGUID("do_not_turn_off")
    if ($do_not_turn_off -ne -1) {
        Write-Host "GUID of do_not_turn_off power setting is $do_not_turn_off"
        powercfg -setactive $do_not_turn_off
        Write-Host "do_not_turn_off power setting is activated!"
        powercfg -list
    }
    else {
        cantgetGUIDerr
    }
}
else {
    cantgetGUIDerr
}

######################################
# Enable wsl2 feature and update kernel
######################################

# Enable wsl feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
# Enable Virtual Machine platform feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

#####################################
# Install Openssh client
#####################################

# If you install Openssh client on Windows, You can use ssh, ssh-keygen, etc... commands!
# see also: https://docs.microsoft.com/ja-jp/windows-server/administration/openssh/openssh_install_firstuse
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

#####################################
# Show Windows10 right-click menu
# by default in Windows11
#####################################

$is_win11 = $false
if ($winver -ge 22000) {
    $is_win11 = $true
}

if ($is_win11 -eq $true) {
    # - Launch registory editor
    # - Move to the Computer\HKEY_CURRENT_USER\Software\Classes\CLSID path
    # - Right-click CLSID and select New(N) -> Key(K)
    # - Create a new key {86ca1aa0-34aa-4e8b-a509-50c905bae2a2}
    # - Selecte a new key and create another new key InprocServer32
    # - Select InprocServer32 key and confirm that the data of value(V) is empty.
    # - Reboot system

    # Create a new key {86ca1aa0-34aa-4e8b-a509-50c905bae2a2} and InprocServer32
    New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force

    # Confirm that the data of value(V) is empty.
    Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value ""

}

Write-Host "Please reboot system to apply the changes."
