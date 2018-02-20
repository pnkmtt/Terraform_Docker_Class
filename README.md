# Vagrant_Ansible_Class
Basic class on Ansible using Vagrant and Virtualbox.

## Introduction

Vagrant is designed to automatically & repeatedly provision development environments on multiple platforms, including Mac OS X, Microsoft Windows, Debian, Ubuntu, CentOS, RedHat and Fedora. In this document we will handle how to configure and run a virtual development environment through Vagrant from scratch to up and running, on Windows environments.

VirtualBox is an Oracle product that allows you to run virtual guests on your machine for development.  Vagrant understands how to call VirtualBox to create an instance on a private network [NAT](https://computer.howstuffworks.com/nat.htm) on your machine so you can easily do development work.


## Installing the Windows development Environment

To install our environment we should follow the below sections in order:


1. Installing Vagrant
1. Installing Git
1. Installing Virtualbox
1. Installing Putty

### Installing Vagrant

First, you need to download Vagrant setup from [http://www.vagrantup.com/downloads.html](http://www.vagrantup.com/downloads.html), and then run it.


The setup wizard is straightforward -- it will ask you to accept the license agreement and the path to install. Since you will need to use command line, you may want to choose a short path. For example in our case, we will use `D:\Vagrant`. The installer may ask you to restart at the end of setup.

### Installing Git

Download Git command line setup from [https://github.com/git-for-windows/git/releases](https://github.com/git-for-windows/git/releases), and then run it.

Alternative: [https://git-scm.com/download/win](https://git-scm.com/download/win)

You may need to update your PATH so that you can find git on the command line. On windows 10 go to this URL for help:  [https://www.java.com/en/download/help/path.xml](https://www.java.com/en/download/help/path.xml)

### Installing VirtualBox


You need now to download VirtualBox, use the following link to download the latest release of VirtualBox [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)

The setup here is somewhat long, but if you just click “Next” without any changes, it will be fine.

### Installing Putty

You now need to download and install Putty. Use the following link to download the latest release of Putty [https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

## Creating your Vagrant VM

Now that we have everything installed we need to download the required Vagrant files.


### Download the class material via git

From a new or existing directory (i.e. `C:\Users\Panik\Downloads`) on the command line, run this command: `git clone https://github.com/pnkmtt/Vagrant_Ansible_Class`

This will download the Vagrant file and allow us to create your new VirtualBox VM in a directory called Vagrant_Ansible_Class.

Once the clone has completed, `cd` to the target directory, For example `cd C:\User\panik\Downloads\Vagrant_Ansible_Class`

We will now create our VM based on the downloaded files, run the command `vagrant up`. The output should be similar to the example below.

You may have to approve the creation of a network adapter on your system -- say yes to any questions, as this does not compromise your OS in any way.

Example output from `vagrant up`:

```
C:\Users\panik\Dropbox\git\Vagrant_Ansible_Class>Bringing machine 'default' up with 'virtualbox' provider...
==> default: Box 'v0rtex/xenial64-iso' could not be found. Attempting to find and install...
    default: Box Provider: virtualbox
    default: Box Version: >= 0
==> default: Loading metadata for box 'v0rtex/xenial64-iso'
    default: URL: https://vagrantcloud.com/v0rtex/xenial64-iso
==> default: Adding box 'v0rtex/xenial64-iso' (v20180126.0.0) for provider: virtualbox
    default: Downloading: https://vagrantcloud.com/v0rtex/boxes/xenial64-iso/versions/20180126.0.0/providers/virtualbox.box
    default:
==> default: Successfully added box 'v0rtex/xenial64-iso' (v20180126.0.0) for 'virtualbox'!
==> default: Importing base box 'v0rtex/xenial64-iso'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'v0rtex/xenial64-iso' is up to date...
==> default: Setting the name of the VM: Vagrant_Ansible_Class_default_1518127578490_62760
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
    default: Adapter 2: hostonly
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Running 'pre-boot' VM customizations...
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Connection reset. Retrying...
    default: Warning: Connection aborted. Retrying...
    default: Warning: Remote connection disconnect. Retrying...
    default: Warning: Connection aborted. Retrying...
    default: Warning: Connection reset. Retrying...
    default: Warning: Connection aborted. Retrying...
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Setting hostname...
==> default: Configuring and enabling network interfaces...
==> default: Mounting shared folders...
    default: /vagrant => C:/Users/panik/Dropbox/git/Vagrant_Ansible_Class

```

## Accessing your new VirtualBox-based VM

Now that the instances is up, ssh into the VM via putty. The host information is 127.0.0.1 and the port is 2222; the user is 'vagrant'; and the password is 'vagrant'.

## Installing Ansible on your new VM

We now need to install Ansible on our new host. Run the following set of commands to install Ansible and its dependencies. In the interest of demonstrating these steps, I did not automate the install process with Vagrant.

```
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt-get install software-properties-common python-software-properties ansible -y
```

To make sure Ansible is installed run `ansible --version`

```
vagrant@myxenial64:/vagrant$ ansible --version
ansible 2.0.0.2
  config file = /etc/ansible/ansible.cfg
  configured module search path = Default w/o overrides
```

We now have a working Ansible install.

## Running our first Ansible playbook

Ansible uses ssh to access the hosts that it configures. Since we are doing this on the newly created VM, we will be ssh'ing to the localhost and configuring our applications.

In order to this we need to take a step to generate an ssh key for the vagrant user and put it in the authorized_keys file. The below example shows the creation of an RSA ssh key and the population of the vagrant user authorized_keys file.

As the vagrant user run `ssh-keygen -t rsa` and accept the defaults.  Once complete, copy the newly generated RSA public key into the vagrant user's authorized_keys file. Run the command `cat .ssh/id_rsa.pub > .ssh/authorized_keys`.  Note: this is not how you would manage the key files in production, but we are using sudo which is preferred over direct root access.

To test the connection ssh to the localhost and you will not need a password `ssh localhost`.  Exit once you have confirmed access.

```
vagrant@myxenial64:~$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/vagrant/.ssh/id_rsa.
Your public key has been saved in /home/vagrant/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:XiBndxIcOQxuaBzyhJoNbi6Bbb7UdD9bBHnMec7FNiQ vagrant@myxenial64
The key's randomart image is:
+---[RSA 2048]----+
|    ..o .Bo+Eo.  |
|  . .= +o X...=  |
|.o =  * *oo=.o . |
|o B o..= o.oo    |
| * o . .S..      |
|. + .  .o..      |
| o .    .+       |
|  .     .        |
|                 |
+----[SHA256]-----+
vagrant@myxenial64:~$ cat .ssh/id_rsa.pub > .ssh/authorized_keys
vagrant@myxenial64:~$ ssh localhost
The authenticity of host 'localhost (::1)' can't be established.
ECDSA key fingerprint is SHA256:7AfUe0N0zVc8EFUtFyzW7f9NlVztFFAdXg9T37N4L8c.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'localhost' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.4.0-112-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
Last login: Fri Feb  9 18:26:40 2018 from 10.0.2.2
vagrant@myxenial64:~$ exit
logout
Connection to localhost closed.
```

## Accessing our Ansible Files

The VM has mounted your working directory as a partition it can access.  This can be found under /vagrant.  Run `cd /vagrant` to enter this directory.

In this directory you will find several files that allow Ansible to configure a host with Apache (a web server), MariaDB (a MySQL database fork), and populates configuration files to allow Apache to store and access data within the database.

* `hosts` - lists all Ansible hosts and configuration parameters such as ssh keys
playbook.yml - base Ansible playbook that details what roles to install on specific hosts, in our case the list is 'all'
* `roles` - directory that holds application definitions
* `roles\apache2` - top level of the apache2 role
* `roles\apache2\tasks` - contains yml files that tell Ansible what action to take
* `roles\apache\files` - contains files that can be copied to the remote hosts
* `roles\mariadb\tasks` - contains yml files that tell Ansible what action to take
* `roles\mariadb\files` - contains files that can be copied to the remote hosts

To have Ansible install Apache and MariaDB, run this command `ansible-playbook -i hosts playbook.yml --sudo`. You will have to accept the ssh key on first access.

Pay attention to the output and you will see each step being taken to configure the applications, insert data, and allow Apache to access MariaDB.

Once the playbook is complete, in your local browser type in the URL `http://localhost:8080/db.php`.  The response comes from the backend MariaDB.

# Clean up your Vagrant install

When you are ready to finish the exercise you should remove your VM.

In order to do this run the follow command from the original directory `vagrant destroy`. You will have to answer `y` to complete the destruction.

```
C:\Users\panik\Dropbox\git\Vagrant_Ansible_Class>vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```
