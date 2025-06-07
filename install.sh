#!/bin/bash
# This script installs system dependencies from a specified requirements file.

REQUIREMENTS_FILE=".evn/requirements.txt"

# Check if Python 3 is installed
if ! command -v python3 &>/dev/null; then
  echo "❌ Python 3 is not installed. Installing..."
  sudo apt update && sudo apt install -y python3
else
  echo "✅ Python 3 is already installed."
fi

# Check if pip3 is installed
if ! command -v pip3 &>/dev/null; then
  echo "❌ pip3 is not installed. Installing..."
  sudo apt install -y python3-pip
else
  echo "✅ pip3 is already installed."
fi

# Check for requirements file
if [[ ! -f "$REQUIREMENTS_FILE" ]]; then
  echo "❌ Requirements file not found: $REQUIREMENTS_FILE"
  exit 1
fi

# Install packages
echo "📦 Installing dependencies from $REQUIREMENTS_FILE..."
pip3 install --user -r "$REQUIREMENTS_FILE"
echo "✅ Installation complete."

# ----------------------------------------------------------------
# Configure SSSD Settings
# shellcheck disable=SC2083
./sssd/tasks/sssd_setting.sh

# ----------------------------------------------------------------

# Configure smbcred.sh
echo "⚙️  Configuring smbcred.sh..."
./credentials/setup_credentials.sh

# ----------------------------------------------------------------

# Configure PAM for expired password GUI notification
./pam-config/setup_pam.sh

# ----------------------------------------------------------------

# Configure Autostart Prompt
echo "⚙️  Configuring autostart prompt..."
sudo cp ./src/autostart-prompt.sh /usr/local/bin/autostart-prompt.sh

# ----------------------------------------------------------------

echo "Configure Network Settings..."
# Configure Network Autostart Script
sudo ./network/setup_network_setting.sh

# ----------------------------------------------------------------

# Configure network drive.....
sudo cp ./map_drive/network-drive.sh
# ----------------------------------------------------------------
echo "✅ All configurations completed successfully."