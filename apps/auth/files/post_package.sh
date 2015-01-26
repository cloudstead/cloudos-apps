#!/bin/bash

if [ -f /etc/krb5kdc/setup.marker ] ; then
  echo "$(date): marker file exists, skipping $0 $@" 2>&1 | tee -a /tmp/kerb.log
else

echo "$(date): started $0 $@" >> /tmp/kerb.log

parent_domain="${1}"
ldap_master_password="${2}"
schema_convert_conf="${3}"

ldap_domain_string="dc=$(echo -n ${parent_domain} | sed -e 's/\./,dc=/g')"

# restore /etc/hosts
if [ -f /etc/hosts.bak ] ; then
  mv /etc/hosts.bak /etc/hosts
fi

# set ldap root password
echo "dn: olcDatabase={1}hdb,cn=config
replace: olcRootPW
olcRootPW: $(slappasswd -s "${ldap_master_password}")" | ldapmodify -Y EXTERNAL -H ldapi:///

# extract & install kerberos schema, set up ACLs
gzip -d /usr/share/doc/krb5-kdc-ldap/kerberos.schema.gz
cp /usr/share/doc/krb5-kdc-ldap/kerberos.schema /etc/ldap/schema/
mkdir /tmp/ldif_output
slapcat -f ${schema_convert_conf} -F /tmp/ldif_output -n0 -s "cn={12}kerberos,cn=schema,cn=config" > /tmp/cn=kerberos.ldif
sed -i 's/{12}kerberos/kerberos/g' /tmp/cn\=kerberos.ldif
head -n -8 /tmp/cn\=kerberos.ldif > /tmp/kerberos.ldif.head
mv /tmp/kerberos.ldif.head /tmp/cn\=kerberos.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -D cn=admin,cn=config -w "${ldap_master_password}" -f /tmp/cn\=kerberos.ldif

echo "dn: olcDatabase={1}hdb,cn=config
add: olcDbIndex
olcDbIndex: krbPrincipalName eq,pres,sub" | ldapmodify -Y EXTERNAL -H ldapi:/// -D cn=admin,cn=config

echo "dn: olcDatabase={1}hdb,cn=config
replace: olcAccess
olcAccess: to attrs=userPassword,shadowLastChange,krbPrincipalKey by dn=\"cn=admin,${ldap_domain_string}\" write by anonymous auth by self write by * none
-
add: olcAccess
olcAccess: to dn.base="" by * read
-
add: olcAccess
olcAccess: to * by dn=\"cn=admin,${ldap_domain_string}\" write by * read" | ldapmodify -Y EXTERNAL -H ldapi:///  -D cn=admin,cn=config

# init kerberos logging files
mkdir -p /var/log/kerberos
touch /var/log/kerberos/{krb5kdc,kadmin,krb5lib}.log
chmod -R 750 /var/log/kerberos

echo "$(date): completed $0 $@" >> /tmp/kerb.log

fi