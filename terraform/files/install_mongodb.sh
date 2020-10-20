#!/bin/bash
sudo apt-get update -y

if [ $(dpkg-query -W -f='${Status}' ca-certificates 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        sudo apt-get install ca-certificates -y
else
    echo "ca-certificates already installed.  Skipping..."
fi

if [ $(dpkg-query -W -f='${Status}' apt-transport-https 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        sudo apt-get install apt-transport-https -y
else
    echo "apt-transport-https already installed.  Skipping..."
fi

if [ $(dpkg-query -W -f='${Status}' mongodb-org 2>/dev/null | grep -c "ok installed") -eq 0 ]
    then
        wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | apt-key add -
        echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
        sudo apt-get update -y
        sudo apt-get install mongodb-org -y
else
    echo "mongodb already installed.  Skipping..."
fi

#ToDo: база доступна всем, переделать
#sudo mongod --bind_ip 0.0.0.0
sudo sed -i -e "s/  bindIp: 127.0.0.1/  bindIp: 0.0.0.0/" /etc/mongod.conf

sudo systemctl restart mongod
sudo systemctl enable mongod
