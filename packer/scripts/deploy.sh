#!/bin/bash
if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        apt-get install git -y
else
    echo "git already installed.  Skipping..."
fi

cd /opt
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

#Create service user
useradd -d /dev/null -s /usr/sbin/nologin reddit-web
chown reddit-web:reddit-web /opt/reddit/* 

#Create unit file
sudo cat <<'EOF' > /opt/reddit-web.service
[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=simple

User=reddit-web

WorkingDirectory=/opt/reddit

ExecStart=/bin/bash -lc 'puma -d'

Restart=always

[Install]
WantedBy=multi-user.target
EOF

#Create service
sudo mv /opt/reddit-web.service /etc/systemd/reddit-web.service

sudo systemctl daemon-reload && sudo systemctl enable reddit-web.service
