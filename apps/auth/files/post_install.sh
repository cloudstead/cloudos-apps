#!/bin/bash

if [ -f /etc/krb5kdc/setup.marker ] ; then
  echo "$(date): marker file exists, skipping $0 $@" 2>&1 | tee -a /tmp/kerb.log

else

echo "$(date): starting $0 $@" >> /tmp/kerb.log
echo "$(date): contents of /etc/krb5.conf: $(cat /etc/krb5.conf)" >> /tmp/kerb.log

parent_domain="${1}"
realm="${2}"
krb_master_password="${3}"
ldap_master_password="${4}"

ldap_domain_string="dc=$(echo -n ${parent_domain} | sed -e 's/\./,dc=/g')"

# start random seeding with hostname, fixed 'random' value, and ifconfig
hostname > /dev/urandom
ifconfig > /dev/urandom
echo 'lajfl;knf2@#g23vASDqnqw$%1' > /dev/urandom

ROOT_DEVICE=$(mount | head -1 | awk '{print $1}')

# further seed randomness with disk image, ping to www. parent domain, and top via background jobs
set -m
cat ${ROOT_DEVICE} > /dev/urandom &
ping www.${parent_domain} > /dev/urandom &
top > /dev/urandom &

echo "${krb_master_password}
${krb_master_password}" | kdb5_ldap_util -D cn=admin,${ldap_domain_string} create -subtrees cn=cloudos,${ldap_domain_string} \
  -r ${realm} -s -w ${ldap_master_password} -H ldapi:///

echo "${ldap_master_password}
${ldap_master_password}
${ldap_master_password}" | kdb5_ldap_util -D cn=admin,${ldap_domain_string} stashsrvpw \
  -f /etc/krb5kdc/service.keyfile cn=admin,${ldap_domain_string}

# stop random seeding
kill %1 %2 %3

# force krb_master_password (for some reason it doesn't seem to get set correctly by now)
echo "change_password kadmin/admin
${krb_master_password}
${krb_master_password}" | kadmin.local

# stash ldap password for ldapscripts
echo -n '${ldap_master_password}' > /etc/ldapscripts/ldapscripts.passwd
chmod 400 /etc/ldapscripts/ldapscripts.passwd

# touch marker file, this script should not run on future installs
touch /etc/krb5kdc/setup.marker

echo "$(date): completed $0 $@" >> /tmp/kerb.log

fi