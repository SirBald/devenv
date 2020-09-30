# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_BOX = "hashicorp/bionic64"
VM_NAME = "base-devenv"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = VAGRANT_BOX
  # You may also specify the URL to a box directly.
  # config.vm.box_url = "https://vagrantcloud.com/hashicorp/bionic64"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "4096"
    vb.name = VM_NAME
  end

  VAGRANT_EXPERIMENTAL="dependency_provisioners"
  config.vm.provision "bashrc-enhancement",
    type: "file",
    source: "provisions/bashrc-enhancements",
    destination: "~/.bashrc-enhancements"
  config.vm.provision "base-tools",
    type: "shell",
    path: "provisions/base-tools.sh",
    after: "bashrc-enhancement"

  # If you want to use synced folder (for syncing files between host and guest
  # machines) then comment the next line which disables the vagrant's default
  # synced folder.
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.ssh.forward_agent = true
end
