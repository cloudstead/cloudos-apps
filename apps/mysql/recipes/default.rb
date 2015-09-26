#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, cloudstead
#
# All rights reserved - Do Not Redistribute
#

%w( mysql-server ).each do |pkg|
  package pkg do
    action :install
  end
end

base = Chef::Recipe::Base
Chef::Recipe::Mysql.set_password(self, 'root', base.password('mysql-root'))
