#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2013, cloudstead
#
# All rights reserved - Do Not Redistribute
#

# every system needs these
%w( apache2 ).each do |pkg|
  package pkg do
    action :install
  end
end

%w( https-services-available https-services-enabled rewrite-rules-available rewrite-rules-enabled mixins ).each do |dir|
  directory "/etc/apache2/#{dir}" do
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end
end

# overwrite ports with our version that sets a few defaults
%w( /etc/apache2/ports.conf ).each do |config|
  if File.exists? config
    template config do
      action :delete
    end
  end
  template config do
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables ({
        :hostname => %x(hostname).strip,
        :ip_address => node['ipaddress'],
    })
  end
end

# Add passwords to env vars
base = Chef::Recipe::Base
envvars='/etc/apache2/envvars'
bash "add passwords to #{envvars}" do
  user 'root'
  code <<-EOF

# Remove any existing _PASSWORD fields that are present
TEMP=$(mktemp /tmp/apache.env.XXXXXXX) || exit 1
chmod 700 ${TEMP}
cat #{envvars} | egrep -v "^export [A-Z_]+_PASSWORD=.+" > ${TEMP}

# Write correct _PASSWORD fields, overwrite the envvars file, delete temp file
echo "
export LDAP_PASSWORD=\"#{base.password 'ldap'}\"
export KADMIN_PASSWORD=\"#{base.password 'kerberos'}\"
export SYSTEM_MAILER_PASSWORD=\"#{base.password 'cloudos_system_mailer'}\"
" >> ${TEMP} && cat ${TEMP} > #{envvars} && chmod 600 #{envvars} && rm ${TEMP}
  EOF
  not_if { File.open(envvars, 'r') { |f| f.read }.include? "LDAP_PASSWORD=\"#{base.password 'ldap'}\"" }
end

# default modules needed by most apps
%w( ssl rewrite headers proxy proxy_http include substitute env setenvif ).each do |mod|
  Apache.enable_module(self, mod)
end

# Disable default site. We will route everything from port 80 to 443
Apache.disable_site(self, 'default')

# Enable GeoIP if one or more databases is provided
geo_db_dir = '/opt/cloudos/geoip'
unless %x(find #{geo_db_dir}/ -type f -name "Geo*2-*.mmdb").strip.empty?

  self.bash 'ensure maxmind PPA is setup and libmaxminddb is installed' do
    user 'root'
    code <<-EOF
if [ $(dpkg -l | grep libmaxminddb | wc -l | tr -d ' ') -eq 0 ] ; then
  echo | add-apt-repository ppa:maxmind/ppa
  apt-get update
  apt-get install libmaxminddb0 libmaxminddb-dev mmdb-bin -y
fi

# Hacky, but some things expect the legacy databases to have a certain name
if [[ -f #{geo_db_dir}/GeoLiteCity.dat && ! -e #{geo_db_dir}/GeoIPCity.dat ]] ; then
    ln -s #{geo_db_dir}/GeoLiteCity.dat #{geo_db_dir}/GeoIPCity.dat
fi

EOF
  end

  Apache.new_module(self, 'maxminddb')
  template '/etc/apache2/mixins/maxmind.conf' do
    owner 'root'
    group 'root'
    mode '0644'
    action :create
    variables ({ :geo_db_dir => geo_db_dir })
  end
end
