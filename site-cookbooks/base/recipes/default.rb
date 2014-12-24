#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# TODO: nkf
%w{vim rsync git}.each do |pkg|
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

# パス追加（/usr/local/bin）
template "Modify Path (root)" do
    user "root"
    source "root_bash_profile.erb"
    path "/root/.bash_profile"
    action :create
end

# yumにepelリポジトリを追加（epelの依存）
bash 'add_epel' do
  user 'root'
  code <<-EOC
    rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
    sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/epel.repo
  EOC
  creates "/etc/yum.repos.d/epel.repo"
  not_if { File.exists?("/etc/yum.repos.d/epel.repo") }
end

# yumにremiリポジトリを追加
bash 'add_remi' do
  user 'root'
  code <<-EOC
    rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    sed -i -e "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/epel.repo
  EOC
  creates "/etc/yum.repos.d/remi.repo"
  not_if { File.exists?("/etc/yum.repos.d/remi.repo") }
end


# heroku toolbelt
bash "Install_heroku_toolbelt" do
    code "wget -qO- https://toolbelt.heroku.com/install.sh | sh"
    not_if "which heroku"
end
link "/usr/local/bin/heroku" do
    to "/usr/local/heroku/bin/heroku"
end

           
           
