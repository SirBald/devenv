# Development environment

## Run base environment

Base environment includes essential development tools like git.

1. Clone repository and run vagrant box
    ```
    git clone git@github.com:SirBald/devenv.git
    cd devenv
    vagrant up
    vagrant ssh
    ```
2. Inside VM configure git
    ```
    git config -e --global
    ```
    Change name and e-mail to meet yours:
    ```
    [user]
            name = <your name>
            email = <your e-mail>
    ```

## Configure VSCode

This allows you to modify and run code located in your guest system using VSCode on host machine.

1. In your terminal type ```vagrant up``` to initialize your Vagrant.
2. Type ```vagrant ssh-config```. This will output valid configuration for SSH config file to SSH into the running Vagrant machine. Copy that.
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

## CPP Environment

When vagrant base environment is up and running to install CPP tools run one of the following command:
```
vagrant provision --provision-with cpp-tools
```
or
```
vagrant reload --provision-with cpp-tools
```
