#!/bin/bash

function die {
  echo 1>&2 "${1}"
  exit 1
}

BACKUP_DIR="${1:?no backup dir specified}"

for ldif in $(find ${BACKUP_DIR} -maxdepth 1 -type f -name "*.ldif") ; do
  db=$(echo $(basename $ldif) | awk -F '-' '{print $3}' | sed -e 's/.ldif$//')
  instance=$(echo $(basename $ldif) | awk -F '-' '{print $2}')
  chown dirsrv ${ldif}
  ns-slapd ldif2db \
    -D /etc/dirsrv/slapd-${instance} \
    -n ${db} \
    -i ${ldif} || die "Error restoring LDAP (db=${db}, instance=${instance})"
done
