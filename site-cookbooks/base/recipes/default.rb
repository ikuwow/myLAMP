#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{vim rsync}.each do |pkg|
    package pkg do
        action :install
    end
end

=begin
network_tools = %w{nslookup}
network_tools.each do |pkg|
    package pkg do
        action :install
    end
end
=end

execute "rm -f /etc/localtime" do
    not_if "test -L /etc/localtime"
end
link "Set localtime" do
    link_type :symbolic
    target_file "/etc/localtime"
    to "/usr/share/zoneinfo/Asia/Tokyo"
end

user "Setting Root Password" do
    username "root"
    password "$1$xwKCp9Sr$FjkErIasrmWahenxL23af1" # root
    action :modify
end

