#!/bin/bash

SUBNET=$(ip -o -f inet addr show | awk '/scope global/ {printf "%s ", $4}' | awk '{print $1}')

apt install ufw -y

ufw default reject incoming
ufw default allow outgoing
ufw limit 22/tcp   #SSH
ufw allow 80/tcp   #HTTP
ufw allow 443/tcp  #HTTPS
ufw limit from "$SUBNET" to any port 9090 proto tcp #COCKPIT
ufw --force enable

ufw status
echo "UFW is $(systemctl is-enabled ufw) and $(systemctl is-active ufw)."
sleep 3s