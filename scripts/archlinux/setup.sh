#!/bin/bash

set -eu

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git

git clone https://github.com/kohei-noda-qcrg/arch-setup.git
pushd arch-setup
./01-setup-rootfs --wsl
./02-setup-dev-and-desktop-env --no-desktop

echo "WSL2 archlinux setup done"