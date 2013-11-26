default['drupal_dev']['dir'] = "/vagrant/frontend"
default['drupal_dev']['db']['db_name'] = "frontend"

override['build_essential']['compiletime'] = true
override['mysql']['server_root_password'] = "root"

override['mysql']['server_repl_password'] = "root"
override['mysql']['server_debian_password'] = "root"