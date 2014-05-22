# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "fedora-20_puppet"
  config.vm.box_url = "http://hill-storage-vagrant-box.s3.amazonaws.com/fedora-20_puppet.box"
  
  config.vm.define "lb" do |lb|
    lb.vm.hostname  = "lb"
    lb.vm.network "private_network", ip: "172.20.20.10"
    lb.vm.provision 'puppet' do |puppet|
      puppet.manifest_file  = "lb.pp"
    end
  end
  config.vm.define "web1" do |web1|
    web1.vm.hostname  = "web1"
    web1.vm.network "private_network", ip: "172.20.20.11"
    web1.vm.provision 'puppet' do |puppet|
      puppet.manifest_file  = "web.pp"
    end
  end
  config.vm.define "web2" do |web2|
    web2.vm.hostname  = "web2"
    web2.vm.network "private_network", ip: "172.20.20.12"
    web2.vm.provision 'puppet' do |puppet|
      puppet.manifest_file  = "web.pp"
    end
  end
  config.vm.define "web3" do |web3|
    web3.vm.hostname  = "web3"
    web3.vm.network "private_network", ip: "172.20.20.13"
    web3.vm.provision 'puppet' do |puppet|
      puppet.manifest_file  = "web.pp"
    end
  end
end
