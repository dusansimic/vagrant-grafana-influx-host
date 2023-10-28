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

  config.vm.provision "Install InfluxDB", type: "shell", path: "scripts/install_influx.sh"

  config.vm.provision "Install Grafana", type: "shell", path: "scripts/install_grafana.sh"

  config.vm.provision "Change settings", type: "shell", inline: <<-SHELL
    # change grafana domain
    sudo sed -i 's/;domain = localhost/domain = 10.255.0.10/' /etc/grafana/grafana.ini
  SHELL
end
