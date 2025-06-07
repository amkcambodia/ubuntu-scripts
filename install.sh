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
