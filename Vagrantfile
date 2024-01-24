# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

SOLUTION = "k8s" # default/devops/k8s
BOXES ={
  "ubuntu" => "ubuntu/focal64",
  "centos" => "centos/7"
}
DISTRO = "centos" # centos/ubuntu
MIRROR = "aliyun" # <empty>/aliyun/tencent
ADMIN_IP = "192.168.56.10"
NODES = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.define "admin", primary: true do |admin|
    admin.vm.box_check_update = true
    admin.vm.box = "#{BOXES[DISTRO]}"

    admin.vm.provider "virtualbox" do |v|
      v.name = "admin"
      v.memory = 4096
      v.cpus = 2
    end

    #配置当前文件夹同步到虚拟机的vagrant目录
    #rsync指定同步方式，rsync可以实现单向的，一次性的同步
    admin.vm.synced_folder ".", "/vagrant", type: "rsync"

    #Private_network Settings
    admin.vm.network "private_network", ip: "#{ADMIN_IP}"
    admin.vm.hostname = "admin"

    #SSH
    admin.ssh.forward_agent = true
    admin.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # Provision admin Node
    admin.vm.provision "shell", path: "./init/init.sh", args: "#{MIRROR}", privileged: false, reset: true
    admin.vm.provision "shell", path: "./solution/#{SOLUTION}/admin.sh", args: "#{ADMIN_IP}", privileged: false, reset: true
  end

  (1..NODES).each do |i|
    config.vm.define "node-#{i}", autostart:true do |node|
      node.vm.box_check_update = true
      node.vm.box = "#{BOXES[DISTRO]}"

      node.vm.provider "virtualbox" do |v|
        v.name = "node-#{i}"
        v.memory = 2048
        v.cpus = 2
      end

      node.vm.synced_folder ".", "/vagrant", type: "rsync"

      # Private_network Settings
      node.vm.network "private_network", ip: "192.168.56.#{i+1}"
      node.vm.hostname = "node-#{i}"

      # SSH
      node.ssh.forward_agent = true
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      # Provision node Node
      node.vm.provision "shell", path: "./init/init.sh", args: "#{MIRROR}", privileged: false, reset: true
      node.vm.provision "shell", path: "./solution/#{SOLUTION}/node.sh", args: "#{ADMIN_IP}", privileged: false, reset: true
    end
  end
end
