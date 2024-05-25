# My-windows-setup

## Setup instructions

1. Boot powershell with administrative privileges
1. Run the folloing commands
    ```powershell
    cd /path/to/scripts
    powershell -ExecutionPolicy ByPass -File "initialize_windows_settings.ps1"
    ```

1. Reboot Windows machine
1. Boot powershell with administrative privileges
1. Run the folloing commands
    ```powershell
    cd /path/to/scripts
    powershell -ExecutionPolicy ByPass -File "windowssetup.ps1"
    ```

1. setup Ubuntu user
1. Boot powershell and run the following commands
    ```powershell
    cd /path/to/scripts
    powershell -ExecutionPolicy Bypass -File "copy.ps1"
    ```

1. Boot Ubuntu and run the following commands
    ```sh
    $HOME/writeubuntusettings.sh && $HOME/ubuntusoftwareinstall.sh
    ```

1. Reboot Windows machine
1. Boot powershell and run the following commands 
    ```powershell
    cd /path/to/scripts
    powershell -ExecutionPolicy ByPass -File "restore_power_settings.ps1"
    ```
