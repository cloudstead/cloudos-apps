#!/bin/bash

function die {
  echo 1>&2 "${1}"
  exit 1
}

BASE=$(cd $(dirname $0) && pwd)
MARKER_FILE=/etc/kolab/.setup.complete
LOG=/tmp/setup-kolab.log

if [ ! -f ${MARKER_FILE} ] ; then
  ${BASE}/setup_kolab_expect.sh $@ 2>&1 > ${LOG} && touch ${MARKER_FILE} || die "Error running setup-kolab"
  rm -f ${LOG} || die "Error removing setup-kolab log file"
  # for some reason wallace is often not running at this point, restart it now
  sevice wallace restart
fi

# clean up Apache configs
KOLAB_WEBAPPS="chwala iRony kolab-freebusy kolab-syncroton kolab-webadmin roundcubemail"
APACHE="/etc/apache2"
SVC_AVAIL="${APACHE}/https-services-available"
SVC_ENABLED="${APACHE}/https-services-enabled"
SITE_AVAIL="${APACHE}/sites-available"
SITE_ENABLED="${APACHE}/sites-enabled"

RESTART_APACHE=0
for service in ${KOLAB_WEBAPPS} ; do

  kolab_installed="${SITE_AVAIL}/${service}.conf"
  avail="${SVC_AVAIL}/${service}"

  if [ ! -e "${avail}" ] ; then
    if [ -e "${kolab_installed}" ] ; then
       mv "${kolab_installed}" "${SVC_AVAIL}" || die "Error moving ${kolab_installed} -> ${SVC_AVAIL}"
       cd ${SVC_ENABLED}
       ln -s ../https-services-available/${service}.conf || die "Error creating symlink for ${service} in ${SVC_ENABLED}"
       cd -
       RESTART_APACHE=1
    else
      echo "${kolab_installed} not found, skipping"
    fi
  fi

  # Remove obsolete files if they exist
  if [[ -e "${kolab_installed}" || -L "${kolab_installed}" ]] ; then
    rm "${kolab_installed}" || die "Error removing ${kolab_installed}"
  fi
  if [[ -e "${SITE_ENABLED}/${service}.conf" || -L "${SITE_ENABLED}/${service}.conf" ]] ; then
    rm "${SITE_ENABLED}/${service}.conf" || die "Error removing ${SITE_ENABLED}/${service}.conf"
  fi

done

# write "shim" config so that kolab paths will bypass any proxy on the document root
if [ ! -e "${SVC_ENABLED}/kolab-shim" ] ; then
  KOLAB_SHIM="${SVC_AVAIL}/kolab-shim"
  KOLAB_MOUNTS="chwala iRony freebusy Microsoft-Server-ActiveSync kolab-webadmin roundcubemail webmail"
  cat /dev/null > "${KOLAB_SHIM}"
  for service in ${KOLAB_MOUNTS} ; do
    echo "ProxyPass /${service} !" >> "${KOLAB_SHIM}" || die "Error writing to ${KOLAB_SHIM}"
  done
  cd ${SVC_ENABLED}
  ln -sf ../https-services-available/kolab-shim || die "Error creating symlink for kolab-shim in ${SVC_ENABLED}"
  cd -
  RESTART_APACHE=1
fi

if [ ${RESTART_APACHE} -eq 1 ] ; then
  service apache2 restart
fi

# Copy CloudOs LDAP schema
CLOUDOS_LDIF="${3}"
INSTALLED_LDIF="$(find $(find /etc/dirsrv/slapd-* -type d -name schema) -type f -name 99user.ldif | sed -e 's/user/cloudos/')"
if [ -z "${INSTALLED_LDIF}" ] ; then
  die "No 99user.ldif found in /etc/dirsrv/slapd-*"
fi
if [ ! -f "${INSTALLED_LDIF}" ] ; then
  cp "${CLOUDOS_LDIF}" "${INSTALLED_LDIF}" || die "Error copying ${CLOUDOS_LDIF} -> ${INSTALLED_LDIF}"
  service dirsrv restart
fi

# Assumes we are using StartCom SSL
# todo: install intermediate cert for arbitrary SSL cert
certutil -d /etc/dirsrv/slapd-$(hostname -s)/ -A -t "CT,," \
  -n "StartCom Certification Authority" \
  -i /usr/share/ca-certificates/mozilla/StartComClass2PrimaryIntermediateServerCA.crt

openssl pkcs12 -export \
  -in /etc/ssl/certs/ssl-https.pem \
  -inkey /etc/ssl/private/ssl-https.key \
  -out /tmp/ldap.p12 -name Server-Cert -passout pass:foo
echo "foo" > /tmp/foo
pk12util -i /tmp/ldap.p12 -d /etc/dirsrv/slapd-$(hostname -s)/ -w /tmp/foo -k /dev/null || die "Error importing SSL cert"
rm -f /tmp/foo /tmp/ldap.p12

ldapmodify -x -h localhost -p 389 -D "cn=Directory Manager" -w ${DIRMAN_PASS} <<EOF
dn: cn=encryption,cn=config
changetype: modify
replace: nsSSL2
nsSSL2: off
-
replace: nsSSL3
nsSSL3: off
-
replace: nsTLS1
nsTLS1: on
-
replace: nsSSLClientAuth
nsSSLClientAuth: allowed

dn: cn=config
changetype: modify
add: nsslapd-security
nsslapd-security: on
-
replace: nsslapd-ssl-check-hostname
nsslapd-ssl-check-hostname: off
-
replace: nsslapd-secureport
nsslapd-secureport: 636

dn: cn=RSA,cn=encryption,cn=config
changetype: add
objectclass: top
objectclass: nsEncryptionModule
cn: RSA
nsSSLPersonalitySSL: Server-Cert
nsSSLToken: internal (software)
nsSSLActivation: on
EOF

