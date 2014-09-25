
class Chef::Recipe::Email

  def self.vmailbox
    '/etc/postfix/vmailbox'
  end

  def self.create_mailbox(chef, account, vmail_user, vmail_group, domain, deliver_to_account = nil)

    email_lib = Chef::Recipe::Email
    vmailbox = email_lib.vmailbox
    deliver_to_account ||= account

    chef.bash "create email account for #{account} in email vhost #{domain}" do
      user 'root'
      cwd '/var/vmail'
      code <<-EOF
# Note the trailing slash after Maildir is IMPORTANT. It says treat this directory like a Maildir
# If the slash is missing, postfix treats it like a regular file and things break
echo "#{account}@#{domain}   #{domain}/#{deliver_to_account}/Maildir/" >> #{vmailbox}
      EOF
      not_if { File.exists?(vmailbox) && File.readlines(vmailbox).grep(/^#{account}@#{domain}/).size > 0 }
    end

    chef.directory "/var/vmail/vhosts/#{domain}/#{deliver_to_account}" do
      owner vmail_user
      group vmail_group
      mode '0700'
      recursive true
      action :create
    end

# Pretty sure we don't need to do this, but leaving commented out for now
#     chef.bash "create mailbox for user #{account} in /var/vmail/vhosts/#{domain}/#{deliver_to_account}" do
#       user 'root'
#       cwd "/var/vmail/vhosts/#{domain}/#{deliver_to_account}"
#       code <<-EOF
# maildirmake.dovecot Maildir #{vmail_user}
#       EOF
#     end

    chef.bash 'compile virtual and vmailbox into postfix db files' do
      user 'root'
      code <<-EOF
postmap #{vmailbox}
      EOF
    end

    # for some reason this directory ends up being owned by root (?)
    email_lib.permission chef, '/var/vmail', nil, vmail_user, vmail_group, nil, true
  end

end