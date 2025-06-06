#!/bin/bash

sudo tee /etc/polkit-1/rules.d/50-networkmanager-ubuntu-group.rules > /dev/null <<EOF
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.NetworkManager.settings.modify.system" &&
        subject.isInGroup("ubuntu-group")) {
        return polkit.Result.YES;
    }
});
EOF
sudo systemctl restart polkit

# shellcheck disable=SC2225
# Copy wifi setting
cp ./template/wifi-settings.sh /usr/local/bin/wifi-setting.sh
sudo chmod 644 /usr/local/bin/wifi-setting.sh
sudo chmod +x /usr/local/bin/wifi-setting.sh

