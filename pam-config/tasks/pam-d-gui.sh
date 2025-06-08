#!/bin/bash

# 🔐 Backup PAM files before modifying
sudo cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak
sudo cp /etc/pam.d/common-password /etc/pam.d/common-password.bak
sudo cp /etc/pam.d/common-session /etc/pam.d/common-session.bak
PAM_FILE="/etc/pam.d/common-session"
PAM_EXEC_LINE="session optional pam_exec.so /usr/local/bin/amk/autostart-prompt.sh"


echo "✅ Backed up PAM config files to *.bak"

# ✅ Enable pam_sss for authentication
if ! grep -q '^auth[[:space:]]\+sufficient[[:space:]]\+pam_sss.so' /etc/pam.d/common-auth; then
    echo 'auth    sufficient    pam_sss.so' | sudo tee -a /etc/pam.d/common-auth > /dev/null
    echo "✅ Added pam_sss to common-auth"
else
    echo "ℹ️ pam_sss already present in common-auth"
fi

# ✅ Enable password change for expired AD accounts
if ! grep -q '^password[[:space:]]\+\[success=1 default=ignore\][[:space:]]\+pam_sss.so' /etc/pam.d/common-password; then
    echo 'password   [success=1 default=ignore]   pam_sss.so use_authtok' | sudo tee -a /etc/pam.d/common-password > /dev/null
    echo "✅ Added pam_sss to common-password"
else
    echo "ℹ️ pam_sss already present in common-password"
fi

# ✅ Enable home directory creation
if ! grep -q '^session[[:space:]]\+required[[:space:]]\+pam_mkhomedir.so' /etc/pam.d/common-session; then
    echo 'session required pam_mkhomedir.so skel=/etc/skel umask=0022' | sudo tee -a /etc/pam.d/common-session > /dev/null
    echo "✅ Added pam_mkhomedir to common-session"
else
    echo "ℹ️ pam_mkhomedir already present in common-session"
fi

# ✅ Add pam_exec to common-session for GUI expired password notification
if ! grep -q 'session optional pam_exec.so quiet expose_authtok' /etc/pam.d/common-session; then
    echo 'session optional pam_exec.so quiet expose_authtok' | sudo tee -a /etc/pam.d/common-session > /dev/null
    echo "✅ Added pam_exec to common-session for expired password GUI prompt"
else
    echo "ℹ️ pam_exec already present in common-session"
fi

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




