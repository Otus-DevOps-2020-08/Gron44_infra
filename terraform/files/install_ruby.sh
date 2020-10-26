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

sudo apt-get update -y

if [ $(dpkg-query -W -f='${Status}' ruby-full 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        sudo apt-get install ruby-full -y
else
    echo "ruby-full already installed.  Skipping..."
fi

if [ $(dpkg-query -W -f='${Status}' ruby-bundler 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        sudo apt-get install ruby-bundler -y
else
    echo "ruby-bundler already installed.  Skipping..."
fi

if [ $(dpkg-query -W -f='${Status}' build-essential 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        sudo apt-get install build-essential -y
else
    echo "build-essential already installed.  Skipping..."
fi
