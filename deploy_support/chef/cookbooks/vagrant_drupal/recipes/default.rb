include_recipe "apt"
include_recipe "apt::default"
include_recipe "build-essential"
include_recipe "git"
include_recipe "mysql::server"
include_recipe "mysql::ruby"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "php::module_gd"
include_recipe "php::module_curl"
include_recipe "apache2"
include_recipe "apache2::mod_php5"

#chef_gem "versionomy"
#require "versionomy"

#install apt packages
%w{unzip libsqlite3-dev php5-mcrypt}.each do |pkg|
  package pkg do
    action :upgrade
  end
end

#add mod_rewrite
apache_module "rewrite" do
  enable true
end

#disable default virtualhost.
apache_site "default" do
  enable false
  
  notifies :restart, "service[apache2]"
end

#create a virtualhost that's mapped to our shared folder and hostname.
web_app "drupal_dev" do
  server_name node['hostname']
  server_aliases node['fqdn'], node['host_name']
  docroot node['drupal_dev']['dir']
  
  notifies :restart, "service[apache2]", :immediately
end

#create a mysql database
mysql_database node['drupal_dev']['db']['db_name'] do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end