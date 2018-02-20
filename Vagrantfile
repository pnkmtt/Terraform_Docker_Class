#
# Single box with VirtualBox provider.
#
# NOTE: Make sure you have the precise32 base box installed...
# vagrant box add precise32 http://files.vagrantup.com/precise32.box
#
# VirtualBox modifyvm docs: http://www.virtualbox.org/manual/h08.html#vboxmanage-modifyvm

domain   = 'example.com'

nodes = [
  { :hostname => 'terraform',   :ip => '192.168.0.42', :box => 'v0rtex/xenial64-iso', :guest => '22', :host => '5555'},
  { :hostname => 'docker',   :ip => '192.168.0.43', :box => 'v0rtex/xenial64-iso', :guest => '22', :host => '5556'},


Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      nodeconfig.vm.network :private_network, ip: node[:ip]
      nodeconfig.vm.boot_timeout = 400
      nodeconfig.vm.network "forwarded_port", guest: node[:guest], host: node[:host]
      memory = node[:ram] ? node[:ram] : 500;

nodeconfig.vm.provider :virtualbox do |vb|
        vb.linked_clone = true
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "30",
          "--memory", memory.to_s,
        ]
  end
end