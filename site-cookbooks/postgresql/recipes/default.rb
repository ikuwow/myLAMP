#
# Cookbook Name:: postgresql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash "add_postgres_rpm" do
    code <<-EOC
    rpm -Uvh http://yum.postgresql.org/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-1.noarch.rpm
    sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/pgdg-93-centos.repo
    EOC
    creates "/etc/yum.repos.d/pgdg-93-centos.repo"
end

package "postgresql93" do
    options "--enablerepo=pgdg93"
    action :install
end
