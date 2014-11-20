#
# Cookbook Name:: cloudos
# Recipe:: validate
#
# Copyright 2014, cloudstead
#

bash 'ensure all services are running' do
  user "root"
  code <<-EOF

if [ $(netstat -nlpt | grep dovecot | wc -c) -eq 0 ] ; then
  service dovecot start
fi

  EOF
end