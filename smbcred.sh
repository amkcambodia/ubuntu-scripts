cat <<'EOF' > /bin/smbcred.sh
#!/bin/bash

cred_file="$HOME/.smbcred"

# Only prompt if file doesn't exist or password is empty
if [ ! -s "$cred_file" ] || ! grep -q "password=" "$cred_file"; then
    domain=$(zenity --entry --title="SMB Login" --text="Enter domain:")
    username=$(zenity --entry --title="SMB Login" --text="Enter username:")
    password=$(zenity --password --title="SMB Login")

    if [ -n "$username" ] && [ -n "$password" ]; then
        cat <<CRED > "$cred_file"
username=$username
password=$password
domain=$domain
CRED
        chmod 600 "$cred_file"
        zenity --info --text="✅ SMB credentials saved successfully."
        echo "✅ SMB credentials saved to $cred_file"
    else
        zenity --error --text="❌ Missing credentials. Login failed."
        echo "❌ Missing username or password. Aborted."
    fi
else
    echo "✅ Credentials already exist in $cred_file"
fi
EOF
chmod +x /bin/smbcred.sh