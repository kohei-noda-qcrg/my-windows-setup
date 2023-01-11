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

### Cisco anyconnect のインストール(HINET 外部のネットワークから HINET 内部のコンピュータ接続時に必要)

- 以下のリンクにアクセスして Cisco anyconnect をダウンロード  
  [https://www2.media.hiroshima-u.ac.jp/sso/vpngw/anyconnect-win-4.10.05085-core-vpn-predeploy-k9.msi](https://www2.media.hiroshima-u.ac.jp/sso/vpngw/anyconnect-win-4.10.05085-core-vpn-predeploy-k9.msi)

- ダウンロードしたファイルをダブルクリック、ダウンロード

  詳しい使い方は [https://www.media.hiroshima-u.ac.jp/services/hinet/vpngw/#setting](https://www.media.hiroshima-u.ac.jp/services/hinet/vpngw/#setting) を参照してください
