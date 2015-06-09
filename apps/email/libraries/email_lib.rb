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

    if is_alias
      # ensure aliases are in virtual file
      virtual_file='/etc/postfix/virtual'
      chef.bash "add email alias #{account} to #{virtual_file}" do
        user 'root'
        code <<-EOF
if [ ! -f #{virtual_file} ] ; then
  touch #{virtual_file}
fi
chown root.root #{virtual_file} && chmod 700 #{virtual_file} && \
echo "
#{account}  #{deliver_to_account}
" >> #{virtual_file}  && \
sed -i '/^ *$/d' #{virtual_file}  # strip blank lines
        EOF
        not_if { %x(cat #{virtual_file} | grep #{account} | wc -l | tr -d '').to_i > 0 }
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
        not_if { %x(cat #{vmailbox}.users | grep #{account} | wc -l | tr -d '').to_i > 0 }
      end
    end

    chef.bash "remap #{vmailbox} #{virtual_file.nil? ? '' : "and #{virtual_file}"} after creating #{account}@#{domain} -> #{deliver_to_account}" do
      user 'root'
      code <<-EOF
postmap #{vmailbox}
if [ ! -z "#{virtual_file}" ] ; then
  if [ -f #{virtual_file} ] ; then
    chown root.root #{virtual_file} &&  chmod 700 #{virtual_file} &&  postmap #{virtual_file}
  fi
fi
EOF
    end

# for some reason this directory ends up being owned by root (?)
    email_lib.permission chef, '/var/vmail', nil, 'vmail', 'vmail', nil, true
  end

  #
  # Delete a mailbox. If new_owner is given, migrate mail to a subfolder of the new owner
  #
  def self.delete_mailbox(chef, account, domain, deliver_to_account = nil, new_owner = nil)
    email_lib = Chef::Recipe::Email
    base_lib = Chef::Recipe::Base
    vmailbox = email_lib.vmailbox
    deliver_to_account ||= account
    is_alias = (deliver_to_account != account)
    new_owner ||= ''

    base_lib.remove_from_file(chef, vmailbox, "#{account}@#{domain}   #{domain}/#{deliver_to_account}/Maildir/")

    chef.bash "remove email account for #{account} in email vhost #{domain}" do
      user 'root'
      cwd '/var/vmail'
      code <<-EOF
dest="/var/vmail/vhosts/#{domain}/#{account}"
mailbox="/var/vmail/vhosts/#{domain}/#{deliver_to_account}"
new_owner="#{new_owner}"

if [[ #{is_alias} ]] ; then
  # remove alias symlink or rename to new_owner
  if [[ -L ${dest} ]] ; then
    if [[ ! -z "${new_owner}" ]] ; then
      echo "Changing alias ${dest} from -> $(readlink ${dest}) to -> ${new_owner}..."
      rm ${dest} && ln -s ${new_owner} ${dest} || exit 1
    else
      rm ${dest}
    fi
  else
    echo "Expected ${dest} to be a symlink (email alias) but it was not"
    # exit 1 # should we bomb an uninstall just because an alias has become a mailbox?
  fi
else
  # remove mailbox, sync files to new_owner
  if [[ ! -z "${new_owner}" ]] ; then
    new_owner_maildir="/var/vmail/vhosts/#{domain}/#{new_owner}"
    archive_dir="${new_owner_maildir}/.archived-mail"
    if [[ ! -d ${archive_dir} ]] ; then
      maildirmake.dovecot ${archive_dir} && \
      chown -R vmail.vmail ${archive_dir} && \
      echo "archived-mail" >> ${new_owner_maildir}/subscriptions
    fi
    archive_user_dir="${archive_dir}.#{account}-$(date +%Y-%m-%d-%H-%M-%S)"
    echo "Archving mailbox ${mailbox} -> ${archive_user_dir}"
    mv ${mailbox} ${archive_user_dir}

  else
    echo "Removing mailbox, no new owner: ${mailbox}"
    rm -rf ${mailbox}
  fi
fi
EOF
    end

    if is_alias
      # remove alias from virtual file
      virtual_file='/etc/postfix/virtual'
      to_remove = "#{account}  #{deliver_to_account}"
      base_lib.remove_from_file(chef, virtual_file, to_remove)
    end

    chef.bash "remap #{vmailbox} #{virtual_file.nil? ? '' : "and #{virtual_file}"} after removing/archiving #{account}" do
      user 'root'
      code <<-EOF
postmap #{vmailbox}
if [[ ! -z "#{virtual_file}" && -f #{virtual_file} ]] ; then postmap #{virtual_file} ; fi
      EOF
    end

# for some reason this directory ends up being owned by root (?)
    email_lib.permission chef, '/var/vmail', nil, 'vmail', 'vmail', nil, true
  end

end