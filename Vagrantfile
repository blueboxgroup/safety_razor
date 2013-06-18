# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "opscode-ubuntu-12.04"
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.2.0.box"

  config.vm.network :forwarded_port, guest: 8026, host: 8026

  config.vm.provision :chef_solo do |chef|
    chef.run_list = ["recipe[razor]"]
    chef.json = {
      :razor => {
        :images => {
          'ubuntu-minimal-10.04' => {
            'url' => 'http://archive.ubuntu.com/ubuntu/dists/lucid/main/installer-amd64/current/images/netboot/mini.iso',
            'checksum' => '72602f91a85a856248e519c6446d303fa8990b4328899385990a95177681dc58',
            'version' => '10.04'
          }
        }
      }
    }
  end
end
