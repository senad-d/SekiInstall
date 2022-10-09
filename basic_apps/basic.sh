#!/bin/bash

apt update
apt install cron -y
apt install nano -y
apt install btop -y
apt upgrade -y

echo "Cron is $(systemctl is-enabled cron) and $(systemctl is-active cron)"
echo "Nano is instaled and $(systemctl is-active cron)"
echo "Btop is instaled and $(systemctl is-active btop)"
sleep 3s

