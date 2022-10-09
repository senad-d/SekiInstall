# Installer
### For Ubuntu 22.04 LTS (minimized install)

In this short video you can see the installation process of this script for "Basic install" and OpenVPN installation with SSL certificate, user and configuration download link.

https://user-images.githubusercontent.com/96924112/181740725-fa98c0fc-8bf5-4bef-994c-c06c902b84a8.mp4


```
git clone https://github.com/sekkigit/SekiTEH-bash.git install && cd install
sudo bash installer.sh
```

#### Install: 

| Program | Description |
| --- | --- |
| OpenVPN | Create a vpn server with vpn-user. |
| Samba | Enables Linux / Unix machines to communicate with Windows machines in a network. |
| Cockpit | Graphical interface to administer servers. |
| CrowdSec | Analyze behaviors, respond to attacks & share signals across the community. |
| Docker-compose | Tool that help define and share multi-container applications. |
| Docker | Enables you to separate your applications from your infrastructure. |
| Plex | Access all media. |
| Automate backup | Back up your files every day/weak/month automatically. |
| Lock SSH | Lock SSH session, accept only your KEY, forbid access from root. |
| Basic apps | Install Nano, Btop, Cron. |
| UFW | Enable and edit rules in UFW firewall. |


#### Bootstrap scripts to choose from


<details><summary>SIMPLE Install</summary>
<p>

#### Create environment for docker containers.
  - Nano
  - Btop
  - Cron
  - Docker

</p>
</details>


<details><summary>BASIC Install</summary>
<p>

#### Create environment for docker containers with basic protection and monitoring.
  - Nano
  - Btop
  - Cron
  - Docker
  - Crowdsec
  - Cockpit
  - UFW

</p>
</details>


<details><summary>FULL Install</summary>
<p>

#### Create environment for docker containers with file sharing, media sharing, basic protection and monitoring.
  - Nano
  - Btop
  - Cron
  - Docker
  - Crowdsec
  - Cockpit
  - UFW
  - Samba
  - Plex

</p>
</details>


<details><summary>Warning</summary>
<p>

#### ⚠️ Please beware that products can change over time.

I do my best to keep up with the latest changes and releases, but please understand that this won’t always be the case.

</p>
</details>
