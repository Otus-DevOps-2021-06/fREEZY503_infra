#!/bin/bash

apt install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
puma -d

#echo "puma -d" >> /etc/rc.local 
#echo "exit 0"
