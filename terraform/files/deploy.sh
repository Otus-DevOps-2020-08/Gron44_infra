#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        sudo apt update -y
        sleep 5
        sudo apt install git -y
else
    echo "git already installed.  Skipping..."
fi
sudo git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl daemon-reload && sudo systemctl enable puma.service && sudo systemctl start puma.service
