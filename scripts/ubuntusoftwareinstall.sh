#!/bin/bash
set -euo pipefail # Abort script when error is occured.

function usage() {
    echo "Usage: $0 [--ci]"
    echo "  --ci: Run in CI mode (Normally, this option is not needed. Skip ubuntu-setup (https://github.com/kohei-noda-qcrg/ubuntu-setup) script)"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
    --ci)
        CI=true
        shift
        ;;
    --help | -h)
        usage
        exit 0
        ;;
    *)
        echo "Unknown argument: $1"
        usage
        exit 1
        ;;
    esac
done

current_dir="$(
    cd "$(dirname "$0")"
    pwd
)"
cd $current_dir

echo -e "============================="
echo -e "Start ubuntusoftwareinstall.sh"
echo -e "============================="

# Update packages
sudo dpkg --configure -a
sudo apt-get update
sudo apt-get -y autoremove

# Upgrade the packages to latest version
sudo apt-get -y full-upgrade

# Install build-essential (gcc etc.)
sudo apt-get install -y build-essential

# Install dependencies
sudo apt-get install -y libbz2-dev libdb-dev libreadline-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libsqlite3-dev libssl-dev zlib1g-dev uuid-dev libffi-dev

# Install pip and python
sudo apt-get install -y python3-pip python3-dev python-is-python3

# Update pip
python -m pip install -U pip --no-warn-script-location

# Install python packages for numerical calculation
python -m pip install numpy scipy pandas matplotlib --no-warn-script-location

# Install python packages for testing
python -m pip install pytest pytest-cov --no-warn-script-location

# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

sudo apt install git
if [ -z ${CI+x} ]; then
    # Install ubuntu-setup
    git clone https://github.com/kohei-noda-qcrg/ubuntu-setup.git "$HOME/ubuntu-setup"
    cd "$HOME/ubuntu-setup"
    ./setup --wsl
else
    echo "CI mode: Skip ubuntu-setup"
fi

echo -e "============================="
echo -e "WSL2 ubuntu setup script ended. Please restart WSL2.\n1. Open powershell\n2. Type \" wsl --shutdown \"\n3. Restart Ubuntu"
echo -e "============================="
