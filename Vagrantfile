# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_BOX = "hashicorp/bionic64"

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
  end

  config.vm.network "forwarded_port", guest: 1433, host: 2433, id: "MS SQL Server"

  VAGRANT_EXPERIMENTAL="dependency_provisioners"
  config.vm.provision "bashrc-enhancement",
    type: "file",
    source: "provisions/bashrc-enhancements",
    destination: "~/.bashrc-enhancements"
  config.vm.provision "base-tools",
    type: "shell",
    path: "provisions/base-tools.sh",
    after: "bashrc-enhancement"
  config.vm.provision "cpp-tools",
    type: "shell",
    path: "provisions/cpp-tools.sh",
    run: "never"
  config.vm.provision "dot-net-core",
    type: "shell",
    path: "provisions/dot-net-core.sh",
    after: "base-tools",
    run: "never"
  config.vm.provision "mssql-server",
    type: "shell",
    path: "provisions/mssql-server.sh",
    after: "base-tools",
    run: "never"
  config.vm.provision "nodejs",
    type: "shell",
    path: "provisions/nodejs.sh",
    after: "base-tools",
    run: "never"

  # If you want to use synced folder (for syncing files between host and guest
  # machines) then comment the next line which disables the vagrant's default
  # synced folder.
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.ssh.forward_agent = true
end
