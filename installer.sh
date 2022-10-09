#!/usr/bin/env bash

apt remove needrestart -y
clear

### Line ##
SPLIT=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }

### Installer Functions #######################################

# Basic install
fn_basic() { echo; 
while true; do
        read -r -p "Do you wish run Basic installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./basic-install.sh; break;;
            [Nn]* ) clear; sub2-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

# Simple install
fn_simple() { echo; 
while true; do
        read -r -p "Do you wish run Simple installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./simple-install.sh; break;;
            [Nn]* ) clear; sub2-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

# Full install
fn_full() { echo; 
while true; do
        read -r -p "Do you wish run Full installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./full-install.sh; break;;
            [Nn]* ) clear; sub2-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

### Program Function #######################################

# Crontask autotask
fn_autorun() { echo; 
while true; do
        read -r -p "Do you wish run Crontask installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./autorun/crontask.sh; break;;
            [Nn]* ) clear; sub-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

# Backup autotask
fn_backup() { echo; 
while true; do
        read -r -p "Do you wish run Backup installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./backup/create_backup.sh; break;;
            [Nn]* ) clear; sub-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

# Basic software
fn_basicapp() { echo; 
while true; do
        read -r -p "Do you wish run Basic software installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./basic_apps/basic.sh; break;;
            [Nn]* ) clear; sub-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

# Lock SSH
fn_sshconf() { echo; 
while true; do
        read -r -p "Do you wish run SSH installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./ssh_conf/ssh_config.sh; break;;
            [Nn]* ) clear; sub-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

# Docker and Docker-compose
fn_docker() { echo; 
while true; do
        read -r -p "Do you wish run Docker installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./docker_install/docker_install.sh; break;;
            [Nn]* ) clear; sub-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

# Firewall UFW
fn_ufw() { echo; 
while true; do
        read -r -p "Do you wish run UFW installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./ufw_install/ufw_basic_install.sh; break;;
            [Nn]* ) clear; sub-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

# OpenVPN
fn_openvpn() { echo; 
while true; do
        read -r -p "Do you wish run OpenVPN installation? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash ./openvpn/openvpn.sh && ufw allow 1194/udp; break;;
            [Nn]* ) clear; sub-submenu;;
            * ) echo "Please answer yes or no.";;
          esac
done }

fn_bye() { echo "Exiting installer."; exit 0; }
fn_fail() { echo "Wrong option." exit 1; }

sub-submenu() {
    echo -ne "
$(yellowprint 'PROGRAMS')
$(yellowprint "$SPLIT")
$(greenprint '1)') Basic Software
$(greenprint '2)') User backup
$(greenprint '3)') SSH lock
$(greenprint '4)') Crontask
$(greenprint '5)') Docker
$(greenprint '6)') OpenVPN
$(blueprint '7)') Back
$(magentaprint '8)') MAIN MENU
$(redprint '0)') Exit
$(yellowprint "$SPLIT")
Choose an option:  "
    read -r ans
    case $ans in
    1)
        clear;
        fn_basicapp
        clear;
        sub-submenu
        ;;
    2)
        clear;
        fn_backup
        clear;
        sub-submenu
        ;;
    3)
        clear;
        fn_sshconf
        clear;
        sub-submenu
        ;;
    4)
        clear;
        fn_autorun
        clear;
        sub-submenu
        ;;
    5)
        clear;
        fn_docker
        clear;
        sub-submenu
        ;;
    6)
        clear;
        fn_openvpn
        clear;
        echo "***** Here is your link which holds configuration for open vpn *****";
        echo
        cat /root/vpn-client-link | sed 's/,/\n/g' | head -n 1;
        rm /root/vpn-client-link &> /dev/null;
        sub-submenu
        ;;
    7)
        clear;
        submenu
        ;;
    8)
        clear;
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

sub2-submenu() {
    echo -ne "
$(yellowprint 'BOOTSTRAP')
$(yellowprint "$SPLIT")
$(greenprint '1)') Basic
$(greenprint '2)') Simple
$(greenprint '3)') Full
$(blueprint '4)') Back
$(magentaprint '5)') MAIN MENU
$(redprint '0)') Exit
$(yellowprint "$SPLIT")
Choose an option:  "
    read -r ans
    case $ans in
    1)
        clear;
        fn_basic
        mainmenu
        ;;
    2)
        clear;
        fn_simple
        mainmenu
        ;;
    3)
        clear;
        fn_full
        mainmenu
        ;;
    4)
        clear;
        submenu
        ;;
    5)
        clear;
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

submenu() {
    echo -ne "
$(blueprint 'INSTALL')
$(yellowprint "$SPLIT")
$(greenprint '1)') Install Programs
$(greenprint '2)') Bootstrap script
$(magentaprint '3)') Back
$(redprint '0)') Exit
$(yellowprint "$SPLIT")
Choose an option:  "
    read -r ans
    case $ans in
    1)
        clear;
        sub-submenu
        submenu
        ;;
    2)
        clear;
        sub2-submenu
        submenu
        ;;
    3)
        clear;
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

infomenu() {
    echo -ne "
$(magentaprint 'INFO')
$(yellowprint "$SPLIT")
$(greenprint '1)') Read more abou the script
$(magentaprint '2)') Back
$(redprint '0)') Exit
$(yellowprint "$SPLIT")
Choose an option:  "
    read -r ans
    case $ans in
    1)
        clear;
        cat info
        mainmenu
        ;;
    2)
        clear;
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

mainmenu() {
    echo -ne "
$(magentaprint 'BOOTSTRAP INSTALLER')
$(yellowprint "$SPLIT")
$(greenprint '1)') Install
$(greenprint '2)') Info
$(redprint '0)') Exit
$(yellowprint "$SPLIT")
Choose an option:  "
    read -r ans
    case $ans in
    1)
        clear;
        submenu
        mainmenu
        ;;
    2)
        clear;
        infomenu
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

mainmenu