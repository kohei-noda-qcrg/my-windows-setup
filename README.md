# My Windows Setup

## Setup instructions

1. Boot powershell with administrative privileges
1. Run the following commands to initialize Windows settings

    ```powershell
    cd /path/to/scripts
    powershell -ExecutionPolicy ByPass -File "initialize_windows_settings.ps1"
    ```

1. Reboot Windows machine
1. Boot powershell with administrative privileges
1. Install winget and some other tools

    ```powershell
    cd /path/to/scripts
    powershell -ExecutionPolicy ByPass -File "winget.ps1"
    ```

1. Install WSL2 and distro that you want to use (but currently only Ubuntu and Arch Linux are supported)

    ```powershell
    cd /path/to/scripts
    $distro = "archlinux" # or "ubuntu"
    powershell -ExecutionPolicy ByPass -File "setup-wsl.ps1" $distro
    ```

1. setup distro user name and password
1. Boot powershell and run the following commands to copy files to WSL home directory

    ```powershell
    cd /path/to/scripts
    $distro = "archlinux" # or "ubuntu"
    powershell -ExecutionPolicy Bypass -File "copy.ps1" $distro
    ```

1. Boot distro you selected and run the following command

    ```sh
    $HOME/setup.sh
    ```

1. Reboot Windows machine
1. Boot powershell and run the following commands

    ```powershell
    cd /path/to/scripts
    powershell -ExecutionPolicy ByPass -File "restore_power_settings.ps1"
