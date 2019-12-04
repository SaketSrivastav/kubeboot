# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# base image
IMAGE_NAME = "generic/ubuntu1804"

# Number of non-master nodes
N = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false
  config.vm.provider :libvirt do |lv|
    lv.memory = 2048
    lv.cpus = 2
  end
  config.vm.define "km", autostart: false do |km|
    km.vm.box = IMAGE_NAME
    km.vm.network "private_network", ip: "192.168.50.10"
    km.vm.hostname = "km"
    km.vm.box_check_update = false
    km.vm.provision "ansible" do |ansible|
      ansible.compatibility_mode = '2.0'
      #ansible.verbose = "v"
      ansible.playbook = "ansible/km-playbook.yml"
      ansible.extra_vars = { 
        ansible_python_interpreter:"/usr/bin/python3",
        node_ip: "192.168.50.10"
      }
    end
  end
  (1..N).each do |i|
    config.vm.define "kn#{i}" do |kn|
      kn.vm.box = IMAGE_NAME
      kn.vm.hostname = "kn#{i}"
      kn.vm.box_check_update = false
      kn.vm.network "private_network", ip: "192.168.50.#{i + 10}"
      kn.vm.provision "ansible" do |ansible|
        ansible.compatibility_mode = '2.0'
        #ansible.verbose = "v"
        ansible.playbook = "ansible/kn-playbook.yml"
        ansible.extra_vars = { 
        ansible_python_interpreter:"/usr/bin/python3",
        node_ip: "192.168.50.#{i + 10}",
      }
      end
    end
  end
end
