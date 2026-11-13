Vagrant.configure("2") do |config|
  # Install once on the Windows host:
  # vagrant plugin install vagrant-hostmanager

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false

  # Keep provisioning scripts in ./scripts relative to this Vagrantfile.
  config.vm.synced_folder ".", "/vagrant", disabled: false

  # Common settings
  config.ssh.insert_key = true

  config.vm.define "db01" do |db01|
    db01.vm.box = "generic/centos9s"
    db01.vm.box_version = "4.3.12"
    db01.vm.hostname = "db01"
    db01.vm.network "private_network", ip: "192.168.56.15"

    db01.vm.provider "vmware_desktop" do |v|
      v.vmx["memsize"] = "1024"
      v.vmx["numvcpus"] = "1"
    end

    db01.vm.provision "shell", path: "scripts/db01.sh"
  end

  config.vm.define "mc01" do |mc01|
    mc01.vm.box = "generic/centos9s"
    mc01.vm.box_version = "4.3.12"
    mc01.vm.hostname = "mc01"
    mc01.vm.network "private_network", ip: "192.168.56.14"

    mc01.vm.provider "vmware_desktop" do |v|
      v.vmx["memsize"] = "512"
      v.vmx["numvcpus"] = "1"
    end

    mc01.vm.provision "shell", path: "scripts/mc01.sh"
  end

  config.vm.define "rmq01" do |rmq01|
    rmq01.vm.box = "generic/centos9s"
    rmq01.vm.box_version = "4.3.12"
    rmq01.vm.hostname = "rmq01"
    rmq01.vm.network "private_network", ip: "192.168.56.13"

    rmq01.vm.provider "vmware_desktop" do |v|
      v.vmx["memsize"] = "512"
      v.vmx["numvcpus"] = "1"
    end

    rmq01.vm.provision "shell", path: "scripts/rmq01.sh"
  end

  config.vm.define "app01" do |app01|
    app01.vm.box = "generic/centos9s"
    app01.vm.box_version = "4.3.12"
    app01.vm.hostname = "app01"
    app01.vm.network "private_network", ip: "192.168.56.12"

    app01.vm.provider "vmware_desktop" do |v|
      v.vmx["memsize"] = "2048"
      v.vmx["numvcpus"] = "2"
    end

    app01.vm.provision "shell", path: "scripts/app01.sh"
  end

  config.vm.define "web01" do |web01|
    web01.vm.box = "bento/ubuntu-22.04"
    web01.vm.hostname = "web01"
    web01.vm.network "private_network", ip: "192.168.56.11"

    web01.vm.provider "vmware_desktop" do |v|
      v.gui = false
      v.vmx["memsize"] = "768"
      v.vmx["numvcpus"] = "1"
    end

    web01.vm.provision "shell", path: "scripts/web01.sh"
    

  end
end
