Vagrant.configure("2") do |config|
  
  config.vm.box = "generic/debian12"
  config.vm.box_version = "4.3.12"
  config.vm.define "test"
  config.vm.hostname = "test"
 
  config.vm.network "private_network", ip: "192.168.10.10"

  config.vm.provider "libvirt" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "2120"
    vb.cpus = 2
  end
end
