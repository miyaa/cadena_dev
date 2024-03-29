# remi repository導入
#remote_file "/tmp/#{node['remi']['file_name']}" do
#  source "#{node['remi']['remote_uri']}"
#  not_if { ::File.exists?("/tmp/#{node['remi']['file_name']}") }
#end
#
#package node['remi']['file_name'] do
#  action :install
#  provider Chef::Provider::Package::Rpm
#  source "/tmp/#{node['remi']['file_name']}"
#end
#

# phpインストール
%w{php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof php-intl phpmyadmin}.each do |p|
	package p do
		action :install
		options "--enablerepo=remi --enablerepo=remi-php56"
	end
end

# php設定
template "php.ini" do
	path "/etc/php.ini"
	source "php.ini.erb"
	mode 0644
	#notifies :restart, 'service[httpd]'
end

#phpmyadmin設定
template "phpMyAdmin.conf" do
	path "/etc/httpd/conf.d/phpMyAdmin.conf"
	source "phpMyAdmin.conf.erb"
	mode 0644
	notifies :restart, 'service[httpd]'
end
