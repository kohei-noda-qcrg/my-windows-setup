#!/bin/bash
set -euo pipefail # Abort script when error is occured.

current_dir="$(
    cd "$(dirname "$0")"
    pwd
)"
cd $current_dir

echo -e "============================="
echo -e "Start ubuntu-setup.sh"
echo -e "============================="

# Update packages
sudo dpkg --configure -a
sudo apt-get update
sudo apt-get -y autoremove

# Upgrade the packages to latest version
sudo apt-get -y full-upgrade

sudo apt install git
if [ ! -e "$HOME/ubuntu-setup" ]; then
    # Install ubuntu-setup
    git clone https://github.com/kohei-noda-qcrg/ubuntu-setup.git "$HOME/ubuntu-setup"
    cd "$HOME/ubuntu-setup"
    ./setup --wsl
fi

echo -e "============================="
echo -e "WSL2 ubuntu setup script ended. Please restart WSL2.\n1. Open powershell\n2. Type \" wsl --shutdown \"\n3. Restart Ubuntu"
echo -e "============================="
