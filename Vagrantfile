# -*- mode: ruby -*-
# vi: set ft=ruby :

# ---- Configuration variables ----
TIME 			  = Time.now.strftime('%Y%m%d%H%M%S')
GUI               = false  # Enable/Disable GUI
RAM               = 2048   # Default memory size in MB
CPUs			  = 2	   # Default count cpus

# Network configuration
#DOMAIN            = ".nat.example.com"
NETWORK           = "192.168.100."
NETMASK           = "255.255.255.0"

# Default Virtualbox .box
# See: https://wiki.debian.org/Teams/Cloud/VagrantBaseBoxes
BOX               = "ubuntu/xenial64"


Vagrant.configure(2) do |config|
  #HOSTS.each do | (name, cfg) |
  #config.vm.provision shell, inline: "apt-get update; apt-get -y upgrade"
  config.vm.box = BOX
  config.vm.provision "shell", path: "master-lamp.sh"
  config.vm.network :private_network, ip: NETWORK+"100"
  config.vm.network :public_network
  config.vm.provider "virtualbox" do |vb|
    vb.gui = GUI
    vb.memory = RAM
	vb.cpus = CPUs
  end

	
  
end