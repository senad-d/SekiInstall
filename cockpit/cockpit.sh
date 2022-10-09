#!/bin/bash

IP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
SUBNET=$(ip -o -f inet addr show | awk '/scope global/ {printf "%s ", $4}' | awk '{print $1}')
NETADAPT=$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")
GATE4=$(ip route | awk '/default/ {print $3; exit}')

apt install cockpit -y

cat <<EOF > /etc/netplan/00-installer-config.yaml
network:
  version: 2
  renderer: NetworkManager
  ethernets:
    $NETADAPT:
      dhcp4: no
      dhcp6: no
      addresses: [$IP/24]
      gateway4:  $GATE4
      nameservers:
              addresses: [8.8.4.4, 8.8.8.8]
EOF

netplan apply
service cockpit start
systemctl start cockpit

echo "Cockpit is $(systemctl is-enabled cockpit) and $(systemctl is-active cockpit)"
sleep 3s