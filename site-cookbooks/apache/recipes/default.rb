#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{httpd}.each do |pkg|
    package pkg do
        action :install
    end
end

service "httpd" do
    action [:start, :enable]
end


template "httpd-config" do
    source "httpd.conf.erb"
    path "/etc/httpd/conf/httpd.conf"
    action :create
    notifies :run, "bash[apply_apache_changes]"
end

bash "apply_apache_changes" do
    code "apachectl graceful"
    action :nothing
end
