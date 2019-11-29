# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "voip" do |voip|
    voip.vm.box = "debian/stretch64"
    voip.vm.hostname = "Voip"
    voip.vm.network "private_network", ip: "192.168.33.10"
  end
  config.vm.define "voiptest" do |voiptest|
    voiptest.vm.box = "archlinux/archlinux"
    voiptest.vm.hostname = "VoipTest"
    voiptest.vm.network "private_network", ip: "192.168.33.20"
  end
end
