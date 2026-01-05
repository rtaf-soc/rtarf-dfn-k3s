#!/bin/bash
set -e

echo "[+] Install dependencies"
sudo apt update
sudo apt install -y \
  curl \
  gnupg \
  lsb-release \
  software-properties-common

echo "[+] Add Zeek APT repository"
curl -fsSL https://download.opensuse.org/repositories/security:zeek/xUbuntu_$(lsb_release -rs)/Release.key \
  | sudo gpg --dearmor -o /usr/share/keyrings/zeek.gpg

echo "deb [signed-by=/usr/share/keyrings/zeek.gpg] \
https://download.opensuse.org/repositories/security:/zeek/xUbuntu_$(lsb_release -rs)/ /" \
| sudo tee /etc/apt/sources.list.d/zeek.list

echo "[+] Install Zeek"
sudo apt update
sudo apt install -y zeek

echo "[+] Zeek version"
zeek --version

echo "[+] Zeek installed at /opt/zeek"
