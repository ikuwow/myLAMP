#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{php php-mbstring}.each do |pkg|
    package pkg do
        options "--enablerepo=remi,remi-php56"
        action :install
        notifies :run, "bash[Restart_Apache]"
    end
end

bash "Restart_Apache" do
    code "apachectl graceful"
    action :nothing
end
