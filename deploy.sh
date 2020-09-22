#!/bin/bash
if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        apt-get install git -y
else
    echo "git already installed.  Skipping..."
fi

cd ~/
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
