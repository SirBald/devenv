# Development environment

To use virtual development environment you need to install
[VirtualBox with Extension Pack](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com).

## Run base environment

Base environment includes essential development tools like git.

1. Clone repository and run vagrant box
    ```
    git clone git@github.com:SirBald/devenv.git
    cd devenv
    vagrant up
    vagrant ssh
    ```
2. Inside VM configure git (if you are using it)
    ```
    git config -e --global
    ```
    Change name and e-mail to meet yours:
    ```
    [user]
            name = <your name>
            email = <your e-mail>
    ```

## Shutdown or destroy virtual environment

Shutdown
```
vagrant halt
```
Destroy
```
vagrant destroy
```

## Configure VSCode

This allows you to modify and run code located in your guest system using VSCode on host machine.

1. In your terminal type ```vagrant up``` to initialize your Vagrant.
2. Type ```vagrant ssh-config```. This will output valid configuration for SSH config file to SSH into the running Vagrant machine.
Copy that.
    ```
    Host default
      HostName 127.0.0.1
      User vagrant
      Port 2222
      UserKnownHostsFile /dev/null
      StrictHostKeyChecking no
      PasswordAuthentication no
      IdentityFile /Users/SomeUser/projects/devenv/.vagrant/machines/default/virtualbox/private_key
      IdentitiesOnly yes
      LogLevel FATAL
      ForwardAgent yes
    ```
3. In *VSCode* install plugin *Remote-SSH*.
4. Press **F1** and type **Remote-ssh: Open configuration file** (start typing and it will appear).
5. Choose something like *~/.ssh/config* and past there content copied in the step 2.
You can optionally change **Host** to whatever you want.
6. Select this connection on remote explorer and connect with *Vagrant*.
7. To make your plugins work remotely open plugins explorer.
In *LOCAL - INSTALLED* list find plugins you want to enable and click *Install in SSH: BlaBlaBla*.

## Additional Environments

### Manual Provision

When vagrant base environment is up and running to install additional tools or programs run the following command:
```
vagrant provision --provision-with <provision-name>
```
where ```<provision-name>``` is one from the list:
* ```cpp-tools``` - CPP with related tools
* ```dot-net-core``` - .NET Core
* ```mssql-server``` - MS SQL Server
* ```nodejs``` - Node.JS

### Automatic Provision

It is possible to run provision automatically on the first VM start up.
Just find required tool mentioning in *Vagrantfile* configuration file and remove line ```run: "never"``` with trailing comma (,)
on preceding line. For example:
```
# BEFORE
config.vm.provision "cpp-tools",
  type: "shell",
  path: "provisions/cpp-tools.sh",
  after: "base-tools",
  run: "never"
```
```
# AFTER
config.vm.provision "cpp-tools",
  type: "shell",
  path: "provisions/cpp-tools.sh",
  after: "base-tools"
```
Thereafter **CPP Tools** will be installed automatically during the first ```vagrant up``` since the last ```vagrant destroy```.

More options when to run provision are described in [Vagrantfile documentation](https://www.vagrantup.com/docs/provisioning/basic_usage#run-once-always-or-never).

## Configure VSCode to connect to remote MS SQL Server

1. Open **Extensions** pane, type **mssql** and select the **SQL Server (mssql)** extension to install.
2. After the installation completes, reload the window to enable the extension.
3. Open **SQL Server** pane and click **Add connection**. Another way is to press **F1**, type **sql** and choose
**MS SQL: Add connection**.
4. To connect to MS SQL Server running in vagrant box use the following parameters (others leave empty):
    * Server name: 127.0.0.1,2433
    * Authentication Type: SQL Login
    * User name: SA
    * Password: SA_vagrant
    * Save Password: Yes
    * Profile Name: vagrant-sql-server
