# Terraform_Docker_Class
Basic class on Ansible using Vagrant and Virtualbox.

## Introduction

Vagrant is designed to automatically & repeatedly provision development environments on multiple platforms, including Mac OS X, Microsoft Windows, Debian, Ubuntu, CentOS, RedHat and Fedora. In this document we will handle how to configure and run a virtual development environment through Vagrant from scratch to up and running, on Windows environments.

VirtualBox is an Oracle product that allows you to run virtual guests on your machine for development.  Vagrant understands how to call VirtualBox to create an instance on a private network [NAT](https://computer.howstuffworks.com/nat.htm) on your machine so you can easily do development work.

Docker is a container technology that enables users to deploy microservices in their enviroments.  In this class we will use Docker as the enviroment that we target with Terraform.

Terraform is a utility that enables the creation of infrastructure within several differnt providers.  In this class we will use Terraform to create docker containers.


## Installing the Windows development Environment

To install our windows working environment we should follow the below sections in order:

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

Make sure Ansible is installed run `ansible --version`

```
vagrant@myxenial64:/vagrant$ ansible --version
ansible 2.0.0.2
  config file = /etc/ansible/ansible.cfg
  configured module search path = Default w/o overrides
```

We now have a working Ansible install.

## Running the setup Ansible playbook to finish our lab enviroment

Start by logging into our new Terraform host.  Open putty and ssh to 127.0.0.1:5555. u: vagrant p: vagrant

```
login as: vagrant
vagrant@127.0.0.1's password:
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.4.0-112-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
vagrant@terraform:~$
```

Now that we have access we need to run the included playbook.  Run the following commands: 

`cd /vagrant`
`ansible-playbook -i /var/tmp/hosts playbook.yml`

Answer yes to accept the ssh key

```
The authenticity of host '192.168.0.43 (192.168.0.43)' can't be established.
ECDSA key fingerprint is SHA256:7AfUe0N0zVc8EFUtFyzW7f9NlVztFFAdXg9T37N4L8c.
Are you sure you want to continue connecting (yes/no)? yes
```

You will see output as ansible sets up a docker host and installs terraform on the local machine.

During this process the packages on the docker host will be updated, the current ansible repository added, and finally the docker service will be installed.  We will also configure the docker service to listen on port 2375.

The terraform host will have v0.11.3 installed.

## Using Terraform to create a docker container

To run Terraform run the blow commands:

`cd /vagrant/files`

Within this directory is the docker_machine.tf file.  This contains the provider settings of the docker host and the definition of the conainters that we will estabish.

To use terraform we must first do a 'terraform init', this downloads the correct libraties to enable terraform to manage docker.

```
$ terraform init

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.docker: version = "~> 0.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Now that terraform is ready to talk to docker we can run 'terraform plan' to see what it thinks it should be creating based on our configuration file. In our case we are creating a single container based on the latest ubuntu image.

```
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + docker_container.nginx-server
      id:                               <computed>
      bridge:                           <computed>
      gateway:                          <computed>
      image:                            "${docker_image.nginx.latest}"
      ip_address:                       <computed>
      ip_prefix_length:                 <computed>
      log_driver:                       "json-file"
      must_run:                         "true"
      name:                             "nginx-server"
      ports.#:                          "1"
      ports.985670353.external:         ""
      ports.985670353.internal:         "80"
      ports.985670353.ip:               ""
      ports.985670353.protocol:         "tcp"
      restart:                          "no"
      volumes.#:                        "1"
      volumes.187550123.container_path: "/usr/share/nginx/html"
      volumes.187550123.from_container: ""
      volumes.187550123.host_path:      "/vagrant/files"
      volumes.187550123.read_only:      "true"
      volumes.187550123.volume_name:    ""

  + docker_image.nginx
      id:                               <computed>
      latest:                           <computed>
      name:                             "nginx:1.11-alpine"


Plan: 2 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

Now that we are happy with our configuration we can allow terraform to create the container run the command: `terraform apply`

```
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + docker_container.nginx-server
      id:                               <computed>
      bridge:                           <computed>
      gateway:                          <computed>
      image:                            "${docker_image.nginx.latest}"
      ip_address:                       <computed>
      ip_prefix_length:                 <computed>
      log_driver:                       "json-file"
      must_run:                         "true"
      name:                             "nginx-server"
      ports.#:                          "1"
      ports.985670353.external:         ""
      ports.985670353.internal:         "80"
      ports.985670353.ip:               ""
      ports.985670353.protocol:         "tcp"
      restart:                          "no"
      volumes.#:                        "1"
      volumes.187550123.container_path: "/usr/share/nginx/html"
      volumes.187550123.from_container: ""
      volumes.187550123.host_path:      "/vagrant/files"
      volumes.187550123.read_only:      "true"
      volumes.187550123.volume_name:    ""

  + docker_image.nginx
      id:                               <computed>
      latest:                           <computed>
      name:                             "nginx:1.11-alpine"


Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_image.nginx: Creating...
  latest: "" => "<computed>"
  name:   "" => "nginx:1.11-alpine"
docker_image.nginx: Still creating... (10s elapsed)
docker_image.nginx: Creation complete after 19s (ID: sha256:bedece1f06cc142829698e6ba8f04d7f...85e14b65f55e6ae4858c2nginx:1.11-alpine)
docker_container.nginx-server: Creating...
  bridge:                           "" => "<computed>"
  gateway:                          "" => "<computed>"
  image:                            "" => "sha256:bedece1f06cc142829698e6ba8f04d7f92e7f1b94b985e14b65f55e6ae4858c2"
  ip_address:                       "" => "<computed>"
  ip_prefix_length:                 "" => "<computed>"
  log_driver:                       "" => "json-file"
  must_run:                         "" => "true"
  name:                             "" => "nginx-server"
  ports.#:                          "" => "1"
  ports.985670353.external:         "" => ""
  ports.985670353.internal:         "" => "80"
  ports.985670353.ip:               "" => ""
  ports.985670353.protocol:         "" => "tcp"
  restart:                          "" => "no"
  volumes.#:                        "" => "1"
  volumes.187550123.container_path: "" => "/usr/share/nginx/html"
  volumes.187550123.from_container: "" => ""
  volumes.187550123.host_path:      "" => "/vagrant/files"
  volumes.187550123.read_only:      "" => "true"
  volumes.187550123.volume_name:    "" => ""
docker_container.nginx-server: Creation complete after 2s (ID: db881288bce354936145ccc8e5dfba619b281b860193b71e4dddfb21265b6157)

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

From terraform we can see what it thinks the current state is and what it would do if we ran `terraform apply` again.

```
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

docker_image.nginx: Refreshing state... (ID: sha256:bedece1f06cc142829698e6ba8f04d7f...85e14b65f55e6ae4858c2nginx:1.11-alpine)
docker_container.nginx-server: Refreshing state... (ID: db881288bce354936145ccc8e5dfba619b281b860193b71e4dddfb21265b6157)

------------------------------------------------------------------------

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.

```


In order to see our container we can log into the docker host with putty 127.0.01:5556 u: vagrant p: vagrant.

By running `sudo docker stats` we can see the running container. I have truncated the below output.

```
CONTAINER ID        NAME                CPU %               MEM USAGE / 
434771e057a2        nginx-server        0.00%               1.359MiB / 
```


# Clean up your Vagrant install

When you are ready to finish the exercise you should remove your VM.

In order to do this run the follow command from the original directory `vagrant destroy`. You will have to answer `y` to complete the destruction.

```
C:\Users\panik\Dropbox\git\Vagrant_Ansible_Class>vagrant destroy
    default: Are you sure you want to destroy the 'default' VM? [y/N] y
==> default: Forcing shutdown of VM...
==> default: Destroying VM and associated drives...
```



