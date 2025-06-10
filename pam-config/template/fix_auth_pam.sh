#!/bin/bash
sudo grep -q "pam_localuser.so" /etc/pam.d/common-auth || sudo sed -i '1i auth    [success=1 default=ignore] pam_localuser.so' /etc/pam.d/common-auth
