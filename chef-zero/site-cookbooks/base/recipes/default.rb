#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
#
# yum関係
%w{gcc make wget telnet readline-devel ncurses-devel gdbm-devel openssl-devel zlib-devel libyaml-devel httpd}.each do |p|
	package p do
		action :install
	end
end


# httpd設定
service "httpd" do
	action [:start, :enable]
end

template "httpd.conf" do
	path "/etc/httpd/conf/httpd.conf"
	source "httpd.conf.erb"
	mode 0644
	notifies :restart, 'service[httpd]'
end
