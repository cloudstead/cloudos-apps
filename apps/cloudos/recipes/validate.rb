#
# Cookbook Name:: cloudos
# Recipe:: validate
#
# Copyright 2014, cloudstead
#

base = Chef::Recipe::Base

bash 'ensure all services are running' do
  user 'root'
  code <<-EOF

if [ $(netstat -nlpt | grep '/dovecot' | wc -c) -eq 0 ] ; then
  service dovecot start
fi
if [ $(netstat -nlpt | grep '/master' | grep ':25' | wc -c) -eq 0 ] ; then
  service postfix restart
fi
if [ $(service cloudos status | grep "is running" | wc -l) -eq 0 ] ; then
  service cloudos restart
fi

  EOF
end