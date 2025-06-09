sudo tee "$SERVICE_FILE" > /dev/null <<EOF
[Unit]
Description=Mount DFS Share
After=network-online.target
Wants=network-online.tar
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=$MOUNT_SCRIPT
ExecStop=$UMOUNT_SCRIPT
[Install]
WantedBy=multi-user.target
EOF