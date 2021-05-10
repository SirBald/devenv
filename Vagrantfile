# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

# You may also specify the URL to a box directly: config.vm.box_url = "https://vagrantcloud.com/hashicorp/bionic64"
# instead of using the following constant and config.vm.box property.
UBUNTU1804X64_BOX = "hashicorp/bionic64"
WINDOWS10X64_BOX = "Microsoft/EdgeOnWindows10"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    # Common confgiuration
    config.ssh.forward_agent = true

    # Ubutntu 18.04 x64 headless configuration
    config.vm.define "ubuntu1804x64", primary: true do |ubuntu1804x64|
        ubuntu1804x64.vm.box = UBUNTU1804X64_BOX

        ubuntu1804x64.vm.provider "virtualbox" do |vb|
            vb.cpus = 2
            vb.memory = "4096"
        end

        ubuntu1804x64.vm.network "forwarded_port", guest: 1433, host: 2433, id: "MS SQL Server"
        ubuntu1804x64.vm.network "forwarded_port", guest: 5001, host: 5001, id: "HTTPS listened by Kestrel"

        # If you want to use synced folder (for syncing files between host and guest
        # machines) then comment the next line which disables the vagrant's default
        # synced folder.
        ubuntu1804x64.vm.synced_folder ".", "/vagrant", disabled: true

        VAGRANT_EXPERIMENTAL="dependency_provisioners"
        ubuntu1804x64.vm.provision "bashrc-enhancement",
            type: "file",
            source: "provisions/bashrc-enhancements",
            destination: "~/.bashrc-enhancements"
        ubuntu1804x64.vm.provision "base-tools",
            type: "shell",
            path: "provisions/base-tools.sh",
            after: "bashrc-enhancement"
        ubuntu1804x64.vm.provision "cpp-tools",
            type: "shell",
            path: "provisions/cpp-tools.sh",
            after: "base-tools",
            run: "never"
        ubuntu1804x64.vm.provision "dot-net-core",
            type: "shell",
            path: "provisions/dot-net-core.sh",
            after: "base-tools",
            privileged: false,
            run: "never"
        ubuntu1804x64.vm.provision "mssql-server",
            type: "shell",
            path: "provisions/mssql-server.sh",
            after: "base-tools",
            run: "never"
        ubuntu1804x64.vm.provision "nodejs",
            type: "shell",
            path: "provisions/nodejs.sh",
            after: "base-tools",
            run: "never"
    end

    # Windows 10 x64 with GUI configuration
    config.vm.define "windows10x64", autostart: false do |windows10x64|
        windows10x64.vm.box = WINDOWS10X64_BOX
        windows10x64.vm.guest = :windows

        windows10x64.vm.provider "virtualbox" do |vb|
            vb.cpus = 2
            vb.memory = 4096
            vb.gui = true
            vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
            vb.customize ['modifyvm', :id, '--graphicscontroller', 'vboxsvga']
            vb.customize ['modifyvm', :id, '--vram', '128']
            # The following doesn't work because vm is not running at this moment. It can be done in provision phase, maybe?
            # vb.customize ['controlvm', :id, 'setvideomodehint', '1600 1200 32']
            vb.customize ['setextradata', :id, 'GUI/ScaleFactor', '1.5']
            vb.customize ['modifyvm', :id, '--audio', 'none']
        end

        windows10x64.vm.communicator = "winrm"
        windows10x64.winrm.username = "IEUser"
        windows10x64.winrm.password = "Passw0rd!"

        windows10x64.vm.synced_folder ".", "/vagrant", automount: true

        # REMINDER:
        # The following provision doesn't work at the moment: "Timed out while waiting for the machine to boot.".
        # And the script itsef cannot be run inside VM: "Could not download ".NET Core SDK" with version = 5.0.202".
        # windows10x64.vm.provision "dotnet-5.0",
        #     type: "shell",
        #     path: "provisions/windows10x64/dotnet-install.ps1",
        #     args: "--version 5.0"
    end
end
