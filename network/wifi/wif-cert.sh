#!/bin/bash

# Predefined SSID
TARGET_SSID="AMKBr"

# Auto-detect Wi-Fi interface
IFACE=$(nmcli -t device status | grep ':wifi:' | cut -d: -f1)
if [[ -z "$IFACE" ]]; then
  echo "❌ No Wi-Fi interface found."
  exit 1
fi

# Paths to certs
HOSTNAME_FQDN=$(hostname -f)
USER_IDENTITY="host/$HOSTNAME_FQDN"
#CLIENT_CERT="/etc/ssl/certs/${HOSTNAME_FQDN}.pem"
#PRIVATE_KEY="/etc/ssl/private/${HOSTNAME_FQDN}.key"
CA_CERT="/etc/ssl/certs/amkcambodia-AMKDC02-CA.pem"

# Check if certs exist
if [[ ! -f "$CLIENT_CERT" || ! -f "$PRIVATE_KEY" || ! -f "$CA_CERT" ]]; then
  echo "❌ Required certificate or key not found."
  exit 1
fi

# Add and auto-connect
echo "🔧 Configuring auto-connect to SSID: $TARGET_SSID"
nmcli connection add type wifi ifname "$IFACE" con-name "$TARGET_SSID" ssid "$TARGET_SSID" \
  wifi-sec.key-mgmt wpa-eap \
  802-1x.eap tls \
  802-1x.identity "$USER_IDENTITY" \
  802-1x.client-cert "$CLIENT_CERT" \
  802-1x.private-key "$PRIVATE_KEY" \
  802-1x.private-key-password-flags 0 \
  802-1x.ca-cert "$CA_CERT" \
  802-1x.system-ca-certs yes \
  wifi-sec.group ccmp \
  connection.autoconnect yes

echo "✅ Wi-Fi profile created and will auto-connect to $TARGET_SSID."
