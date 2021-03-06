#!/bin/bash
sudo apt-get update -y
sudo apt update -y
sleep 5

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
sleep 5
