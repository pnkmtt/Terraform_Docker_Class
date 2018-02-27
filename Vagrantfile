#
# Single box with VirtualBox provider.
#
# NOTE: Make sure you have the precise32 base box installed...
# vagrant box add precise32 http://files.vagrantup.com/precise32.box
#
# VirtualBox modifyvm docs: http://www.virtualbox.org/manual/h08.html#vboxmanage-modifyvm

domain   = 'example.com'

nodes = [
  { :hostname => 'terraform',   :ip => '192.168.0.42', :box => 'v0rtex/xenial64-iso', :guest => '22', :host => '5555', :guest2 => '80', :host2 => '8080'},
  { :hostname => 'docker',   :ip => '192.168.0.43', :box => 'v0rtex/xenial64-iso', :guest => '22', :host => '5556', :guest2 => '80', :host2 => '8081'},
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      # https://www.virtualbox.org/manual/ch06.html#network_internal
      nodeconfig.vm.network :private_network, ip: node[:ip], virtualbox__intnet: true
      nodeconfig.vm.boot_timeout = 300
      nodeconfig.vm.network "forwarded_port", guest: node[:guest], host: node[:host]
      nodeconfig.vm.network "forwarded_port", guest: node[:guest2], host: node[:host2]
      memory = node[:ram] ? node[:ram] : 500;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.linked_clone = true
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "30",
          "--memory", memory.to_s,
        ]
      end
      ## Run scripts that match pre-<nameofthebox>.sh  
      ## have to drop the ssh keys to allow ansible to work - this is not how you would do it in prod!
      if File.exists?(File.expand_path(File.join(File.dirname(__FILE__), "./scripts/pre-#{node[:hostname]}.sh")))
        nodeconfig.vm.provision :shell do |shell|
          shell.path = File.expand_path(File.join(File.dirname(__FILE__), "./scripts/pre-#{node[:hostname]}.sh"))
#          #shell.args = "#{environment} #{sourcedir}"
        end
      end
    end
  end
end


