sudo grep /etc/xdg/autostart/smbcred.desktop && sudo cp /etc/xdg/autostart/smbcred.desktop /etc/xdg/autostart/smbcred.desktop.bk
cat <<EOF > /etc/xdg/autostart/smbcred.desktop
[Desktop Entry]
Type=Application
Exec=/bin/bash -c "/bin/smbcred.sh >> /tmp/smbcred.log 2>&1"
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Please Update Your New Password
Comment=Please Update Your New Password
EOF
chmod +x /etc/xdg/autostart/smbcred.desktop
chmod 644 /etc/xdg/autostart/smbcred.desktop
