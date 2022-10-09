#!/bin/bash

SPLIT="$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)"
SSHD=$(cat <<EOF
MaxAuthTries 3
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
UsePAM yes
PubkeyAuthentication yes 
EOF
)

echo ""
while true; do
        read -r -p "Do you wish to edit sshd_config and add your .pub key? 
Yes | No -->  " yn
echo ""
echo "$SPLIT"
echo ""
        case $yn in
            [Yy]* ) echo "Please enter your .pub key here:";
read -r -p "id_rsa.pub --> " PUB;
echo "$PUB" >> /home/"${SUDO_USER:-$USER}"/.ssh/authorized_keys ;
echo "$SSHD" >> /etc/ssh/sshd_config
echo ""
echo "$SPLIT"
echo ""
            break;;
            [Nn]* ) echo ""; exit;;
            * ) echo "Please answer Yes or No.";;
          esac
        done

sleep 2s