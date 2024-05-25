#!/bin/bash
set -euo pipefail # Abort script when error is occured.
cd "$(dirname "$0")"

echo -e "============================="
echo -e "Start writeubuntusettings.sh"
echo -e "============================="
# Manually update DNS server settings
sudo sh -c 'echo "[network]\ngenerateResolvConf = false" > /etc/wsl.conf'
if [ -e /etc/resolv.conf ]; then
	sudo mv /etc/resolv.conf /etc/resolv.conf.old
fi
sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'

echo -e "DNS server settings successed"

# Enable WSL2 to change permissions on Windows files.
sudo sh -c 'echo "[automount]\noptions = \"metadata\"" >> /etc/wsl.conf'

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
