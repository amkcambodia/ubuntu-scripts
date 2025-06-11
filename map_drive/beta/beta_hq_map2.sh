#!/bin/bash


# /etc/fstab
//amkcambodia.com/amkdfs /media/Collaboration-Q cifs credentials=/etc/smbcred/$USERNAME,uid=1000,gid=1000,prefixpath=Collaboration,sec=ntlmssp,vers=3.0,user 0 0
//amkcambodia.com/amkdfs /media/Department-N    cifs credentials=/etc/smbcred/$USERNAME,uid=1000,gid=1000,prefixpath=Dept_Doc/CIO/ITI,sec=ntlmssp,vers=3.0,user 0 0
//amkcambodia.com/amkdfs /media/Home-H          cifs credentials=/etc/smbcred/$USERNAME,uid=1000,gid=1000,prefixpath=StaffDoc/ITD/$USERNAME,sec=ntlmssp,vers=3.0,user 0 0
