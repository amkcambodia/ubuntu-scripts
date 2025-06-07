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
# Rename the LAN configuration script to main.sh
echo "Start Configuring LAN settings..."

python3 ./tasks/rename_network.py

echo "Completed rename LAN."
sudo mkdir -p /usr/local/bin/network && sudo chmod 755 /usr/local/bin/network

cat <<EOF>> /etc/profile.d/setup_lan.sh
#!/bin/bash
python3 /usr/local/bin/network/setup_lan.py
EOF

sudo cp ./template/setup_lan.py /usr/local/bin/network/setup_lan.py
sudo chmod 755 /etc/profile.d/setup_lan.sh && sudo chmod +x /etc/profile.d/setup_lan.sh
sudo chmod 755 /usr/local/bin/network/setup_lan.py && chmod 755 /usr/local/bin/network/setup_lan.py

echo "Start Configuring LAN settings..."
