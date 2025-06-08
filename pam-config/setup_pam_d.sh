#!/bin/bash
# Configure PAM for GUI expired password notification
./pam-config/tasks/pam-d-gui.sh
# sudo -u "$PAM_USER" zenity --error --text="🔐 Your AD password has expired. Press Ctrl+Alt+F3 to change it."