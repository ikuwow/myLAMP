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
    not_if { File.exists?("/etc/yum.repos.d/pgdg-93-centos.repo") }
end

%w{postgresql93 postgresql93-server postgresql93-libs postgresql93-contrib postgresql93-devel}.each do |pkg|
    package pkg do
        options "--enablerepo=pgdg93"
        action :install
    end
end

# /var/lib/pgsql/9.3/dataがemptyだったらinitialize
bash "Initialize postgresql" do
    code "/usr/pgsql-9.3/bin/postgresql93-setup initdb"
    not_if "test `ls /var/lib/pgsql/9.3/data | wc -l` -gt 0"
end

service "postgresql-9.3" do
    action [:enable, :start]
end
