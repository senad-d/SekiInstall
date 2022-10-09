#!/bin/bash

apt install docker.io -y
apt install docker-compose -y
groupadd --system dockergroup
useradd --system --no-create-home --group dockergroup,"${SUDO_USER:-$USER}" -s /bin/false docker
chown -R "${SUDO_USER:-$USER}":docker /home/"${SUDO_USER:-$USER}"
usermod -aG docker,adm "${SUDO_USER:-$USER}"

cat <<EOF >> /etc/cron.d/crontask
25 5 * * * root    docker system prune -a -f
EOF
crontab -u "${SUDO_USER:-$USER}" /etc/cron.d/crontask

echo "Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker). Docker system prune automated."
sleep 3s