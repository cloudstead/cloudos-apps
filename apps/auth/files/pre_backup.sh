#!/bin/bash

BACKUP_DIR="${1}"
if [ -z "${BACKUP_DIR}" ] ; then
  echo "No backup-dir specified"
  exit 1
fi

FILES_DIR=${BACKUP_DIR}/tmp

mkdir -p ${FILES_DIR}
slapcat -n 1 -a '(!(|(objectclass=dcObject)(objectclass=krbContainer)(objectclass=krbRealmContainer)(krbPrincipalName=*kadmin*)(krbPrincipalName=*krbtgt*)(krbPrincipalName=*cloudos*)(krbPrincipalName=*K\2fM*)(cn=admin)))' > ${FILES_DIR}/data.ldif

if [ ! -f ${FILES_DIR}/data.ldif ] ; then
  echo "unable to dump ldap database"
  exit 1
fi
