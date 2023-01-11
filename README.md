# My-windows-setup

```powershell
cd /path/to/scripts
powershell -ExecutionPolicy ByPass -File "initialize_windows_settings.ps1"
```

Restart machine

```powershell
cd /path/to/scripts
powershell -ExecutionPolicy ByPass -File "windowssetup.ps1"
```

After setup Ubuntu user, run following command

```powershell
cd /path/to/scripts
powershell -ExecutionPolicy Bypass -File "copy.ps1"
```

```sh
$HOME/writeubuntusettings.sh && $HOME/ubuntusoftwareinstall.sh
```

```powershell
wsl --shutdown
```

```sh
$HOME/vscodeubuntusetup.sh
```

```powershell
cd /path/to/scripts
powershell -ExecutionPolicy ByPass -File "restore_power_settings.ps1"
```

### Cisco anyconnect のインストール(HINET 外部のネットワークから HINET 内部のコンピュータ接続時に必要)

- 以下のリンクにアクセスして Cisco anyconnect をダウンロード  
  [https://www2.media.hiroshima-u.ac.jp/sso/vpngw/anyconnect-win-4.10.05085-core-vpn-predeploy-k9.msi](https://www2.media.hiroshima-u.ac.jp/sso/vpngw/anyconnect-win-4.10.05085-core-vpn-predeploy-k9.msi)

- ダウンロードしたファイルをダブルクリック、ダウンロード

  詳しい使い方は [https://www.media.hiroshima-u.ac.jp/services/hinet/vpngw/#setting](https://www.media.hiroshima-u.ac.jp/services/hinet/vpngw/#setting) を参照してください
