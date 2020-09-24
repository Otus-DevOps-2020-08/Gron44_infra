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
useradd -M -u 777 reddit-web
chown reddit-web:reddit-web /opt/reddit/* 

#Create unit file
cat > ~/reddit-web.service <<'EOF' 
[Unit]
Description=Puma HTTP Server
Requires=network.target

[Service]
Type=simple

User=reddit-web

WorkingDirectory=/opt/reddit

ExecStart='/usr/local/bin/puma'

Restart=always

[Install]
WantedBy=multi-user.target
EOF

#Create service
mv ~/reddit-web.service /etc/systemd/system/reddit-web.service

systemctl daemon-reload && systemctl enable reddit-web
