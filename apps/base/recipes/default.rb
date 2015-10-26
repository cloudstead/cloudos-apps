#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, cloudstead
#

require 'securerandom'

# ensure packages are up to date
bash 'apt-get update' do
  user 'root'
  code <<-EOF
# Install docker key
apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Add docker apt repository
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list

apt-get update

# Install docker
apt-get install docker-engine -y
apt-get upgrade docker-engine -y
service docker restart

EOF
end

# if ntp is installed, uninstall it first. otherwise openntpd will not install correctly
ntp_installed=%x(dpkg -l | awk '{print $2}' | egrep '^ntp$' | wc -l | tr -d ' ').strip
unless ntp_installed.to_s.empty? || ntp_installed.to_i == 0
  %x(if [ -f /etc/apparmor.d/usr.sbin.ntpd ] ; then apparmor_parser -R /etc/apparmor.d/usr.sbin.ntpd ; fi ; apt-get purge -y ntp)
end

# every system needs these
%w( openntpd safe-rm uuid ).each do |pkg|
  package pkg do
    action :install
  end
end

# common utilities
%w( emacs24-nox tshark xtail screen ).each do |pkg|
  package pkg do
    action :install
  end
end

base = Chef::Recipe::Base
[ '/root/.screenrc', "#{base.chef_user_home}/.screenrc" ].each do |screenrc|
  cookbook_file screenrc do
    source 'dot-screenrc'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
end

startcom_ca_cert_name='StartComClass2PrimaryIntermediateServerCA'
startcom_ca_cert="/usr/share/ca-certificates/mozilla/#{startcom_ca_cert_name}.crt"
startcom_ca_cert_hash='5a5c01b6.0'
ca_cert_dir='/etc/ssl/certs'
cookbook_file startcom_ca_cert do
  source 'StartComClass2PrimaryIntermediateServerCA.pem'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

bash 'install StartCom CA Cert' do
  user 'root'
  code <<-EOF
cd #{ca_cert_dir} && \
rm -f #{startcom_ca_cert_name}.pem && \
ln -s #{startcom_ca_cert} #{startcom_ca_cert_name}.pem && \
ln -s #{startcom_ca_cert_name}.pem #{startcom_ca_cert_hash}
  EOF
  not_if { File.exist? "#{ca_cert_dir}/#{startcom_ca_cert_hash}" }
end

bash 'install data_files' do
  user 'root'
  code <<-EOF
DATA_DIR="/opt/cloudos"
DATA_FILES="#{base.chef_dir}/data_files"
mkdir -p ${DATA_DIR} && chown root.root ${DATA_DIR} && chmod 755 ${DATA_DIR}
if [ $(find ${DATA_FILES} -type f 2> /dev/null | wc -l | tr -d ' ') -gt 0 ] ; then
  rsync -avzc ${DATA_FILES}/* ${DATA_DIR}/
  for f in $(find ${DATA_DIR} -type f -name "*.gz") ; do
    gunzip ${f}
  done
  chmod -R 755 ${DATA_DIR}
fi
EOF
end

rules='/etc/iptables.d'
bash "touch #{rules}" do
  user 'root'
  code <<-EOF
mkdir -p #{rules}
  EOF
  not_if { File.exist? rules }
end

%w( iptables_header iptables_footer ).each do |rule|
  template "#{rules}/#{rule}" do
    owner 'root'
    group 'root'
    mode '0600'
    action :create
  end
end

template '/etc/network/if-pre-up.d/iptables_load' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end
