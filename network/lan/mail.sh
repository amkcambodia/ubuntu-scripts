#!/bin/bash

# This script installs system dependencies from a requirements file.
set -e

echo "[*] Starting setup..."

# Step 1: Install system dependencies from apt-requirements.txt
APT_REQ="./env/apt-requirements.txt"
if [ -f "$APT_REQ" ]; then
    echo "[*] Installing system dependencies from $APT_REQ..."
    sudo apt update
    xargs -a "$APT_REQ" sudo apt install -y
else
    echo "[!] No apt-requirements.txt found at $APT_REQ"
fi

echo "[+] Setup complete."

# Configure LAN configurations
# Rename the LAN configuration script to mail.sh
python3 ./tasks/rename_network.py

echo "Completed rename LAN."

echo "Start Configuring LAN settings..."
