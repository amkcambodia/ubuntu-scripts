#!/bin/bash

# Log output
LOG="/var/log/pam_exec.log"
exec >> "$LOG" 2>&1

echo "=== $(date) Starting PAM setup ==="

# Run each setup script
/usr/bin/python3 /path/to/setup_lan.py
/usr/bin/python3 /path/to/rename_network.py

echo "=== $(date) Finished PAM setup ==="
