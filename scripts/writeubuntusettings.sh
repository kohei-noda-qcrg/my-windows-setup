#!/bin/bash
set -euo pipefail # Abort script when error is occured.
cd "$(dirname "$0")"

echo -e "============================="
echo -e "Start writeubuntusettings.sh"
echo -e "============================="

# Enable WSL2 to change permissions on Windows files.
sudo sh -c 'echo "[automount]\noptions = \"metadata\"" >> /etc/wsl.conf'

# Launch systemd instead of Microsoft init.
sudo sh -c 'echo "[boot]\nsystemd=true" >> /etc/wsl.conf' 

# ssh config
mkdir -p "$HOME/.ssh"
touch "$HOME/.ssh/config"
echo -e "You need to write your ssh config to $HOME/.ssh/config"

# Locale settings
# See also : https://askubuntu.com/questions/683406/how-to-automate-dpkg-reconfigure-locales-with-one-command
sudo echo "locales locales/default_environment_locale select en_US.UTF-8" | sudo debconf-set-selections
sudo echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8" | sudo debconf-set-selections
sudo rm "/etc/locale.gen"
sudo dpkg-reconfigure --frontend noninteractive locales
echo -e "Changed locale to en_US.UTF8."

echo -e "============================="
echo -e "WSL2 ubuntu setting write script ended."
echo -e "============================="

bash ubuntu-setup.sh
