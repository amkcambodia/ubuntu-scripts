#!/bin/bash
sudo apt install smbclient zenity -y

# Configure smbcred.sh script
./tasks/smbcred.sh
chmod 755 /bin/smbcred.sh
chmod +x /bin/smbcred.sh

# Configure autostart for smbcred.sh
./tasks/autostart.sh
sudo grep /etc/xdg/autostart/smbcred.desktop && sudo cp /etc/xdg/autostart/smbcred.desktop /etc/xdg/autostart/smbcred.desktop.bk
sudo chmod 755 /etc/xdg/autostart/smbcred.desktop
sudo chmod +x /etc/xdg/autostart/smbcred.desktop

