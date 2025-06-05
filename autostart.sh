cat <<EOF > /etc/xdg/autostart/smbcred.desktop
[Desktop Entry]
Type=Application
Exec=/bin/smbcred.sh >> /tmp/smbcred.log 2>&1
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=SMB Credentials Prompt
Comment=Run SMB credentials script after login
EOF
chmod 644 /etc/xdg/autostart/smbcred.desktop
