#!/bin/bash

mkdir -p /backup/{daily,weekly,monthly}
mkdir /backup-task

cat <<EOF >> /backup-task/backup-daily.sh
#!/bin/bash

tar -zcf /backup/daily/backup-\$(date +%Y%m%d).tar.gz /home/${SUDO_USER:-$USER}/*
find /backup/daily/* -mtime +7 -delete -exec rm {} \; 
EOF
chmod +x /backup-task/backup-daily.sh

cat <<EOF >> /backup-task/backup-weekly.sh
#!/bin/bash

tar -zcf /backup/weekly/backup-\$(date +%Y%m%d).tar.gz /home/${SUDO_USER:-$USER}/*
find /backup/weekly/* -mtime +31 -delete -exec rm {} \; 
EOF
chmod +x /backup-task/backup-weekly.sh

cat <<EOF >> /backup-task/backup-monthly.sh
#!/bin/bash

tar -zcf /backup/monthly/backup-\$(date +%Y%m%d).tar.gz /home/${SUDO_USER:-$USER}/*
find /backup/monthly/* -mtime +365 -delete -exec rm {} \; 
EOF
chmod +x /backup-task/backup-monthly.sh

cat <<EOF >> /etc/cron.d/crontask
30 5 * * * root    /backup-task/backup-daily.sh
40 5 * * 1 root    /backup-task/backup-weekly.sh
50 5 1 * * root    /backup-task/backup-monthly.sh
EOF
crontab -u "${SUDO_USER:-$USER}" /etc/cron.d/crontask
bash /backup-task/backup-daily.sh

echo "Backup started"
sleep 3s