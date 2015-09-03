#
# Cookbook Name:: djbdns
# Recipe:: default
#
# Copyright 2014, cloudstead
#
# All rights reserved - Do Not Redistribute
#

%w( daemontools daemontools-run ucspi-tcp djbdns ).each do |pkg|
  package pkg do
    action :install
  end
end

user 'dnslog' do
  shell '/bin/false'
end

user 'tinydns' do
  shell '/bin/false'
end

user 'axfrdns' do
  shell '/bin/false'
end

bash 'configure tinydns' do
  user 'root'
  cwd '/tmp'
  code <<-EOF
tinydns-conf tinydns dnslog /etc/tinydns/ #{node[:ipaddress]}
axfrdns-conf axfrdns dnslog /etc/axfrdns /etc/tinydns #{node[:ipaddress]}

if [ ! -d /etc/service ] ; then
  mkdir /etc/service
fi
cd /etc/service && ln -sf /etc/tinydns/ && ln -sf /etc/axfrdns/
initctl start svscan
EOF
  not_if { File.exists? '/etc/tinydns' }
end

begin
  bag = data_bag_item('djbdns', 'init')

  if defined? bag['allow_axfr']
    template '/etc/axfrdns/tcp' do
      source 'axfrdns_tcp.erb'
      owner 'root'
      group 'root'
      mode '0644'
      variables ({ :allow => bag['allow_axfr'] })
      action :create
    end

    bash 'refresh axfrdns' do
      user 'root'
      cwd '/etc/axfrdns'
      code <<-EOF
make && svc -h /etc/service/axfrdns
EOF
    end
  end

rescue => e
  puts "cloudos-dns/init databag not found or error reading, no AXFR hosts will be allowed: #{e}"
end
