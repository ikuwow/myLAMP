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

