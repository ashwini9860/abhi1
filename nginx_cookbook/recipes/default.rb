#
# Cookbook Name:: abhi1
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "update" do
	command "apt-get update -y"
	action :run
end

package "nginx" do
	action :install
end
package "php5-fpm" do
	action :install
end

execute "mv /etc/nginx/sites-available/default /etc/nginx/sites-avilable/default.disable"  do
	only_if do
		File.exist?("/etc/nginx/sites-available/default")
	end

#	notifies :restart, "service[nginx]"
end
cookbook_file "/etc/nginx/sites-available/w.default" do
source "w.default"
mode "0744"
owner "root"
group "rooot"
end

execute "cp /etc/nginx/sites-available/w.default /etc/nginx/sites-available/default" do
end
execute "ln -s /etc/nginx/sites-available/w.default /etc/nginx/sites-enabled/" do
end
#execute "remove" do
#command "rm /etc/nginx/sites-enabled/default"
#action :run
#end
cookbook_file "/usr/share/nginx/www/index.php" do
source "index.php"
mode "0644"
owner "root"
group "root"
end
service "nginx" do
action :restart
end
service "php5-fpm" do
action :restart
end
