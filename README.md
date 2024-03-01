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
1. Boot Ubuntu and run the following commands 
    ```sh
    $HOME/vscodeubuntusetup.sh
    ```

1. Boot powershell and run the following commands 
    ```powershell
    cd /path/to/scripts
    powershell -ExecutionPolicy ByPass -File "restore_power_settings.ps1"
    ```

1. Show Windows 10 right-click menu by default in Windows 11

  - Launch registory editor
  - Move to the Computer\HKEY_CURRENT_USER\Software\Classes\CLSID path
  - Right-click CLSID and select New(N) -> Key(K)
  - Create a new key {86ca1aa0-34aa-4e8b-a509-50c905bae2a2}
  - Selecte a new key and create another new key InprocServer32
  - Select InprocServer32 key and confirm that the data of value(V) is empty.
  - Reboot system
