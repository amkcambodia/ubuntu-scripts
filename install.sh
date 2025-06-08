#!/bin/bash
# This script installs system dependencies from a specified requirements file.

echo ""
echo "🛠️  Select Setup Option:"
echo "  1) Fresh Setup (Full configuration)"
echo "  2) Custom Map Drive Only"
read -rp "Enter your choice [1-2]: " SETUP_OPTION

case "$SETUP_OPTION" in
  1)
    echo ""
    echo "🚀 Starting Fresh Setup..."
    ;;

  2)
    echo ""
    echo "📂 Redirecting to Custom Map Drive Script..."
    chmod +x ./map_drive/map_drive.sh
    ./map_drive/map_drive.sh
    exit 0
    ;;

  *)
    echo "❌ Invalid option. Exiting."
    exit 1
    ;;
esac

# ------------------- Fresh Setup Starts Here -------------------
REQUIREMENTS_FILE=".env/requirements.txt"

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

##################################################################
# ----------------------------------------------------------------
# 1. Configure SSSD Settings
# shellcheck disable=SC2083

./sssd/tasks/sssd_setting.sh
sudo systemctl daemon-reload

# ----------------------------------------------------------------

# 2. Configure smbcred.sh
echo "⚙️  Configuring smbcred.sh..."
./credentials/setup_credentials.sh

# ----------------------------------------------------------------

# 3. Configure PAM for expired password GUI notification
./pam-config/setup_pam_d.sh

# ----------------------------------------------------------------

# 4. Configure Autostart Prompt
echo "⚙️  Configuring autostart prompt..."
if [ ! -d /usr/local/bin/amk ]; then
    echo "📁 Creating /usr/local/bin/amk directory..."
    sudo mkdir -p /usr/local/bin/amk
else
    echo "📂 /media already exists."
fi

sudo cp ./scipts/startup_all.sh /usr/local/bin/amk/autostart-prompt.sh

# ----------------------------------------------------------------

echo "Configure Network Settings..."
# 5. Configure Network Autostart Script
sudo ./network/setup_network_setting.sh

# ----------------------------------------------------------------

# 6. Configure network drive.....
sudo ./map_drive/map_drive.sh
# ----------------------------------------------------------------
echo "✅ All configurations completed successfully."