#!/bin/bash

# download repo key
curl -sLO https://repos.influxdata.com/influxdata-archive.key

# verify and install repo key
echo '943666881a1b8d9b849b74caebf02d3465d6beb716510d86a39f6c8e8dac7515 influxdata-archive.key' | sha256sum -c && cat influxdata-archive.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive.gpg >/dev/null

# create repo file
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list

# clean up
rm influxdata-archive.key

# install influxdb
sudo apt-get update && sudo apt-get install -y influxdb2

# start influxdb
sudo systemctl start influxdb

# enable influxdb
sudo systemctl enable influxdb
