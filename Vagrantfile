# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = 'precise64'

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  # These ports are used to avoid conflicts with local services.
  config.vm.network :forwarded_port, guest: 80, host: 1080
  config.vm.network :forwarded_port, guest: 3306, host: 3307

  # This is to ensure Magento can write it's generated data to our media and var directories.
  config.vm.synced_folder "../flightright-website", "/vagrant/frontend", mount_options: ["dmode=777", "fmode=777"]

  config.vm.provider :virtualbox do |vb|
    # headless mode = false, gui mode = true
    vb.gui = false
  
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize [
      "modifyvm", :id, 
      "--memory", "1536",
      "--cpus", "2"     
    ]
  end


  config.vm.provision :chef_solo do |chef|
    chef.roles_path = 'deploy_support/chef/roles'
    chef.cookbooks_path = 'deploy_support/chef/cookbooks'
    chef.add_role 'drupal_dev'
    chef.json = { 
      'drupal_dev' => {
        'dir' => '/vagrant/frontend/'
      },
      'mysql' => {
        'bind_address' => '0.0.0.0'
      }
    }
    # Chef Logging
    #chef.log_level = :debug
  end
end
