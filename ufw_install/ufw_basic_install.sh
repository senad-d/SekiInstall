#!/bin/bash

apt install ufw -y

ufw default reject incoming
ufw default allow outgoing
ufw limit 22/tcp   #SSH
ufw --force enable

ufw status
echo "UFW is $(systemctl is-enabled ufw) and $(systemctl is-active ufw)."
sleep 3s