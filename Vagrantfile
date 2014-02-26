# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
  config.vm.box = "vishaaka"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  config.vm.hostname = "vishaaka"
  config.vm.synced_folder "./data", "/vagrant_data"
  config.vm.synced_folder "./work", "/work"

  config.vm.provider "virtualbox" do |v|
     #v.gui = true
     v.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
     v.customize ["modifyvm", :id, "--memory", "2048"]
     v.customize ["modifyvm", :id, "--vram", "256"]
  end

  #config.vm.provision :shell, :inline => "apt-get update"
  #config.vm.provision :shell, :path => "provision.sh"
  #config.vm.provision :shell, :inline => "cp -fv /vagrant_data/hosts /etc/hosts"

  if File.exist?("./data/jdk-6u35-linux-x64.bin") then
   config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file = "jdk.pp"
   end
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.module_path = "puppet/modules"
    puppet.manifest_file  = "default.pp"
    puppet.options = ['--verbose --debug']
  end


end
