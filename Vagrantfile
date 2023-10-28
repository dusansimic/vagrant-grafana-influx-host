# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "forwarded_port", guest: 8086, host: 8086 # influxdb
  config.vm.network "forwarded_port", guest: 3000, host: 3000 # grafana
  config.vm.network "private_network", ip: "10.255.0.10" # private network

  config.vm.provision "Ubuntu upgrade and dependencies", type: "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y apt-transport-https ca-certificates software-properties-common curl gnupg2
  SHELL

  config.vm.provision "Install InfluxDB", type: "shell", inline: <<-SHELL
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
  SHELL

  config.vm.provision "Install Grafana", type: "shell", inline: <<-SHELL
    # download and install repo key
    curl -sL https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/grafana.gpg >/dev/null
    # create repo file
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    # install grafana
    sudo apt-get update && sudo apt-get install -y grafana
    # start grafana
    sudo systemctl start grafana-server
    # enable grafana
    sudo systemctl enable grafana-server
  SHELL
end
