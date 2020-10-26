#!/bin/bash

#check for locked files
lock_files=(
    /var/lib/dpkg/lock
    /var/lib/apt/lists/lock
    /var/lib/dpkg/lock-frontend
    /var/cache/apt/archives/lock
    /var/lib/apt/daily_lock
)
for file in "${lock_files[@]}"; do
    while fuser "$file" >/dev/null 2>&1; do
        echo "Waiting for lock $file to be available..."
        sleep 3
    done
done

if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        sudo apt-get install git -y
else
    echo "git already installed.  Skipping..."
fi

cd ~/
sudo git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
