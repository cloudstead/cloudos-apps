require 'inifile'

class Chef::Recipe::LdapHelper

  KOLAB_CONF = '/etc/kolab/kolab.conf'

  def initialize (chef, app)
    @ldap = nil
    @chef = chef
    @app = app
  end

  # lazy init. the KOLAB_CONF file may not exist until later
  def config
    unless @ldap
      # remove curly-brace sections from conf file, ruby inifile parser chokes on them
      temp_conf=%x(tmp=$(mktemp /tmp/kolab.conf.XXXXXX) && chmod 600 ${tmp} && cat #{KOLAB_CONF} | sed '/{/,/}/d' | grep -v '}' > ${tmp} && echo ${tmp}).strip
      @ldap = IniFile.load(temp_conf)['ldap']
      File.delete temp_conf
    end
    @ldap
  end

  def val (field, default)
    if defined?(config[field]) && config[field].to_s != ''
      @app[:lib].subst_string(config[field], @app).to_s
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
    val 'domain', '@hostname'
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
    val 'admin', 'Directory Manager'
  end

  def admin_dn
    # default 'cn=Directory Manager'
    val 'admin_dn', "cn=#{admin}"
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
    val 'name', %x(hostname -s).strip
  end

  def name_dn
    # default 'cn=short-hostname'
    "cn=#{name}"
  end

  def base_dn
    # default 'cn=short-hostname,dc=cloudstead,dc=io'
    val 'base_dn', "#{name_dn},#{ldap_domain}"
  end

  def external_id
    # default 'cn=admin,dc=short-hostname,dc=cloudstead,dc=io'
    val 'external_id', 'entryUUID'
  end

  def users
    # default 'ou=People,cn=short-hostname,dc=cloudstead,dc=io'
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
    # default 'ou=Groups,cn=short-hostname,dc=cloudstead,dc=io'
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

  def group_usernames
    val 'group_usernames', 'uniqueMember'
  end

  def method_missing(method, *args, &block)

    # Looking for a forced-lowercase version of something?
    if method.to_s.end_with?('_lc') && methods.include?(method.to_s[0..-4].to_sym)
      return send(method.to_s[0..-4].to_sym).downcase
    end

    # Or a non-standard field defined in the databag?
    @app[:lib].subst_string(config[method], @app) if config[method]

    # Otherwise, it's undefined
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
    config.each_key { |k|
      hash[k] = @app[:lib].subst_string(config[k], @app) unless hash[k] || k == 'password'
    }
    hash
  end

  def create_user (chef, username, password)
    chef.bash "create LDAP user #{username}" do
      code <<-EOH
echo "dn: uid=#{username},ou=People,dc=cloudstead,dc=io
objectClass: top
objectClass: inetorgperson
objectClass: kolabinetorgperson
objectClass: mailrecipient
objectClass: organizationalperson
objectClass: person
uid: #{username}
userpassword: #{password}
" | ldapadd -x -H ldap://127.0.0.1 -D "cn=Directory Manager" -w dirman

EOH
    end
  end

  def delete_user (chef, username)
    raise 'not yet implemented'
  end

end