#!/bin/bash

# download repo key
curl -sLO https://apt.grafana.com/gpg.key

# verify and install repo key
echo '58052c148058ace26dbd01ce057afa5709fb9d39c8a8ab16800be3f42fc02ab2  gpg.key' | sha256sum -c && cat gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/grafana.gpg >/dev/null

# create repo file
echo "deb [signed-by=/etc/apt/trusted.gpg.d/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# clean up
rm gpg.key

# install grafana
sudo apt-get update && sudo apt-get install -y grafana

# start grafana
sudo systemctl start grafana-server

# enable grafana
sudo systemctl enable grafana-server
