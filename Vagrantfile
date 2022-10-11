VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    #config.ssh.private_key_path = "~/.ssh/id_rsa"
	config.vm.define "web01" do |web01|
		web01.vm.box = "bento/ubuntu-20.04"
        web01.vm.hostname = "web01"
		web01.vm.network :private_network, ip: "192.168.33.52"
	    web01.vm.provision :ansible do |ansible|
			ansible.verbose = "-vvvv"
			ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
			ansible.inventory_path = "./inventory"
			ansible.playbook = "playbook.yml"
			ansible.limit = "all"
		end
	end
    config.vm.define "web02" do |web02|
		web02.vm.box = "bento/centos-7"
		web02.vm.hostname = "web02"
		web02.vm.network :private_network, ip: "192.168.33.50"
		web02.vm.provision :ansible do |ansible|
				ansible.verbose = "-vvvv"
				ansible.extra_vars = { ansible_ssh_user: 'vagrant' }
				ansible.inventory_path = "./inventory"
				ansible.playbook = "playbook.yml"
				ansible.limit = "all"
		end
	end
end 
