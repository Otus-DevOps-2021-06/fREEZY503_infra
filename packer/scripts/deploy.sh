#!/bin/bash

mv ~/puma.service /etc/systemd/system/puma.service
apt install -y git
sleep 2
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
sleep 2
puma -d
systemctl enable puma.service

