#!/bin/bash

PLEX="/home/${SUDO_USER:-$USER}/plexserver"

mkdir "$PLEX"
apt install apt-transport-https curl wget -y
wget -O- https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor | sudo tee /usr/share/keyrings/plex.gpg
echo deb [signed-by=/usr/share/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
apt update
echo N | apt install plexmediaserver -y
groupadd --system plexgroup
useradd --system --no-create-home --group plexgroup -s /bin/false plexserver
chown -R plexserver: "$PLEX"

systemctl enable plexmediaserver
systemctl start plexmediaserver

cat <<EOF > /etc/ufw/applications.d/plexmediaserver
[plexmediaserver-all]
title=Plex Media Server (Standard + DLNA)
description=The Plex Media Server (with additional DLNA capability)
ports=32400/tcp|3005/tcp|5353/udp|8324/tcp|32410:32414/udp|1900/udp|32469/tcp
EOF

systemctl restart plexmediaserver

echo "Plex is $(systemctl is-enabled plexmediaserver) and $(systemctl is-active plexmediaserver)."
sleep 3s