require 'uri'
require 'json'
require 'yaml'

class Chef::Recipe::Kerberos

  def self.create_user(chef, username, password)
    chef.bash "kerberos.create_user #{username}" do
      user 'root'
      cwd '/tmp'
      code <<-EOF
echo "delprinc #{username}
yes" | kadmin.local

echo "addprinc -pw #{password} #{username}" | kadmin.local
      EOF
      not_if { %x(echo listprincs | kadmin.local | grep #{username}@ | wc -l).to_i > 0 }
    end
  end

  def self.delete_user(chef, username)
    chef.bash "kerberos.delete_user #{username}" do
      user 'root'
      cwd '/tmp'
      code <<-EOF
echo "delprinc #{username}
yes" | kadmin.local
      EOF
      not_if { %x(echo listprincs | kadmin.local | grep #{username}@ | wc -l).to_i == 0 }
    end
  end

end

class Chef::Recipe::LdapHelper

  def initialize (chef, app)
    @ldap = chef.data_bag_item('auth', 'init')['ldap']
    @app = app
  end

  def val (field, default)
    if defined?(@ldap[field]) && @ldap[field].to_s != ''
      @app[:lib].subst_string(@ldap[field], @app).to_s
    else
      @app[:lib].subst_string(default, @app).to_s
    end
  end

  def server
    val 'server', 'ldap://127.0.0.1:389'
  end

  def scheme
    URI.parse(server).scheme
  end

  def host
    URI.parse(server).host
  end

  def port
    URI.parse(server).port
  end

  def domain
    val 'domain', '@domain'
  end

  def ldap_domain
    domainify domain
  end

  def domainify(val)
    "dc=#{val.gsub('.', ',dc=')}"
  end

  def realm
    val 'realm', domain
  end

  def org_unit_class
    val 'org_unit_class', 'organizationalUnit'
  end

  def version
    val 'version', '3'
  end

  def admin
    val 'admin', 'admin'
  end

  def admin_dn
    # default 'cn=admin,dc=cloudstead,dc=io'
    val 'admin_dn', "cn=#{admin},#{ldap_domain}"
  end

  def transport
    val 'transport', 'plain'
  end

  def secure
    %w(tls ssl).include? transport
  end

  def password
    Chef::Recipe::Base.password 'ldap'
  end

  def name
    val 'name', 'cloudos'
  end

  def name_dn
    # default 'cn=cloudos'
    "cn=#{name}"
  end

  def base_dn
    # default 'cn=cloudos,dc=cloudstead,dc=io'
    val 'base_dn', "#{name_dn},#{ldap_domain}"
  end

  def external_id
    # default 'cn=admin,dc=cloudstead,dc=io'
    val 'external_id', 'entryUUID'
  end

  def users
    # default 'ou=People,cn=cloudos,dc=cloudstead,dc=io'
    val 'users', 'People'
  end

  def user_simple_dn
    "ou=#{users}"
  end

  def user_dn
    val 'user_dn', "#{user_simple_dn},#{base_dn}"
  end

  def user_class
    val 'user_class', 'inetorgperson'
  end

  def user_filter
    val 'user_filter', "(objectclass=#{user_class})"
  end

  def user_username
    val 'user_username', 'uid'
  end

  def user_displayname
    val 'user_displayname', 'displayName'
  end

  def user_firstname
    val 'user_firstname', 'givenName'
  end

  def user_lastname
    val 'user_lastname', 'sn'
  end

  def user_groupnames
    val 'user_groupnames', 'memberOf'
  end

  def user_username_rdn
    val 'user_username_rdn', 'cn'
  end

  def user_password
    val 'user_password', 'userPassword'
  end

  def user_encryption
    val 'user_encryption', 'sha'
  end

  def groups
    # default 'ou=Groups,cn=cloudos,dc=cloudstead,dc=io'
    val 'groups', 'Groups'
  end

  def group_simple_dn
    "ou=#{groups}"
  end

  def group_dn
    val 'group_dn', "#{group_simple_dn},#{base_dn}"
  end

  def group_class
    val 'group_class', 'groupOfUniqueNames'
  end

  def group_filter
    val 'group_filter', "(objectclass=#{group_class})"
  end

  def group_name
    val 'group_name', 'cn'
  end

  def method_missing(method, *args, &block)
    @app[:lib].subst_string(@ldap[method], @app) if @ldap[method]
    "--undefined: #{method} (#{self})--"
  end

  def to_json
    safe_hash.to_json
  end

  def to_yaml
    safe_hash.to_yaml
  end

  def safe_hash
    hash = {}
    %w( server domain realm transport name org_unit_class version admin admin_dn external_id base_dn
        users user_dn user_class user_filter user_username user_displayname user_firstname user_lastname
        user_groupnames user_username_rdn user_password user_encryption groups
        group_dn group_class group_filter group_name ).each do |attr|
      hash[attr] = self.send attr
    end

    # admin may have defined additional properties. Add everything we haven't already added, but NOT password.
    @ldap.each_key { |k|
      hash[k] = @app[:lib].subst_string(@ldap[k], @app) unless hash[k] || k == 'password'
    }
    hash
  end

end