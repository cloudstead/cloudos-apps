require 'securerandom'

class Chef::Recipe::Email

  def self.vmailbox
    '/etc/postfix/vmailbox'
  end

  def self.sha_file(file)
    Digest::SHA256.file(file).hexdigest
  end

  def self.create_mailbox(chef, account, domain, deliver_to_account = nil)

    email_lib = Chef::Recipe::Email
    vmailbox = email_lib.vmailbox
    deliver_to_account ||= account
    is_alias = (deliver_to_account != account)

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
      owner 'vmail'
      group 'vmail'
      mode '0700'
      recursive true
      action :create
    end

    if is_alias
      chef.bash "create maildir symlink for #{account} -> #{deliver_to_account}" do
        user 'root'
        code <<-EOF

mailbox="/var/vmail/vhosts/#{domain}/#{deliver_to_account}"
dest="/var/vmail/vhosts/#{domain}/#{account}"

if [ -f ${dest} ] ; then
  echo "Cannot change existing mailbox into alias: ${dest}"
  exit 1

elif [ -L ${dest} ] ; then
  if [ $(readlink ${dest}) == "${mailbox}" ] ; then
    echo "Nothing to do, ${dest} already points to ${mailbox}"
    exit 0
  fi
  echo "Changing alias ${dest} from -> $(readlink ${dest}) to -> ${mailbox}..."
  rm ${dest} && ln -s ${mailbox} ${dest} || exit 1

else
  echo "Creating alias ${dest} -> ${mailbox}..."
  ln -s /var/vmail/vhosts/#{domain}/#{deliver_to_account} ${dest} || exit 1
fi
        EOF
      end
    end
# Pretty sure we don't need to do this, but leaving commented out for now
#     chef.bash "create mailbox for user #{account} in /var/vmail/vhosts/#{domain}/#{deliver_to_account}" do
#       user 'root'
#       cwd "/var/vmail/vhosts/#{domain}/#{deliver_to_account}"
#       code <<-EOF
# maildirmake.dovecot Maildir #{vmail_user}
#       EOF
#     end

    chef.bash "remap vmailbox file #{vmailbox} (sha #{sha_file vmailbox})" do
      user 'root'
      code <<-EOF
postmap #{vmailbox}
      EOF
    end

    if is_alias
      # ensure aliases are in virtual file
      virtual_file='/etc/postfix/virtual'
      chef.bash "add email alias #{account} to #{vmailbox}.alias" do
        user 'root'
        code <<-EOF
  echo "
#{account}  #{deliver_to_account}
" >> #{virtual_file}  && \
sed -i '/^ *$/d' #{virtual_file}  # strip blank lines
        EOF
        not_if { %x(cat #{virtual_file} | grep #{account} | wc -l | tr -d '').strip.to_i > 0 }
      end

    else
      # ensure users are in vmailbox.users file
      chef.bash "add email account #{account} to #{vmailbox}.users" do
        user 'root'
        code <<-EOF
  echo "
#{account}
" >> #{vmailbox}.users && \
sed -i '/^ *$/d' #{vmailbox}.users  # strip blank lines
        EOF
        not_if { %x(cat #{vmailbox}.users | grep #{account} | wc -l | tr -d '').strip.to_i > 0 }
      end
    end

    # for some reason this directory ends up being owned by root (?)
    email_lib.permission chef, '/var/vmail', nil, 'vmail', 'vmail', nil, true
  end

end