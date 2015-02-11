#!/bin/bash

BACKUP_DIR="${1}"
if [ -z "${BACKUP_DIR}" ] ; then
  echo "No backup dir specified"
  exit 1
fi

service krb5-admin-server stop || echo "krb5-admin-server not running"
service krb5-kdc stop || echo "krb5-kdc not running"
service slapd stop || echo "slapd not running"

FILES_DIR=${BACKUP_DIR}/tmp

slapadd -F /etc/ldap/slapd.d -n 1 -l ${FILES_DIR}/data.ldif
