#!/bin/bash

PAM_FILE="/etc/pam.d/common-session"
PAM_EXEC_LINE="session optional pam_exec.so /usr/local/bin/setup_all.sh"

# Check if running as root
if [[ $EUID -ne 0 ]]; then
  echo "❌ Please run this script as root (e.g., sudo)."
  exit 1
fi

# Check if any pam_exec.so line exists
if grep -q "^session optional pam_exec.so" "$PAM_FILE"; then
  echo "✅ A pam_exec.so line already exists in $PAM_FILE — skipping."
else
  echo "$PAM_EXEC_LINE" >> "$PAM_FILE"
  echo "✅ Added pam_exec.so line to $PAM_FILE"
fi
