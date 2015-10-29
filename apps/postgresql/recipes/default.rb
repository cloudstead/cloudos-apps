#
# Cookbook Name:: postgresql
# Recipe:: default
#
# Copyright 2013-2015, cloudstead
#
# All rights reserved - Do Not Redistribute
#

%w( postgresql-9.3 ).each do |pkg|
  package pkg do
    action :install
  end
end

bash 'ensure postgresql is running' do
  user 'root'
  code <<-EOF
status="$(service postgresql status)"
if [ -z "${status}" ] ; then
  echo "Error getting postgresql service status"
  exit 1
fi
if [[ ! "${status}" =~ "online" ]] ; then
  service postgresql restart
fi
  EOF
end
