cat <<EOF > /etc/xdg/autostart/smbcred.desktop
[Desktop Entry]
Type=Application
Exec=/bin/smbcred.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=SMB Credentials Prompt
Comment=Run SMB credentials script after login
EOF
chmod +x /etc/xdg/autostart/smbcred.desktop