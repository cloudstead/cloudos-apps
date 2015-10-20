#!/bin/bash

function die {
  echo 1>&2 "${1}"
  exit 1
}

BACKUP_DIR="${1:?no backup dir specified}"
PHASE="${2:?no phase specified, use --before or --after}"

if [ ! -d ${BACKUP_DIR} ] ; then
  mkdir -p ${BACKUP_DIR} || die "Error creating backup dir ${BACKUP_DIR}"
fi
chown root.dirsrv ${BACKUP_DIR} || die "Error setting permissions on ${BACKUP_DIR}"
chmod 770 ${BACKUP_DIR} || die "Error setting ownership on ${BACKUP_DIR}"

if [ "${PHASE}" == "--before" ]; then
  for dir in $(find /etc/dirsrv/ -mindepth 1 -maxdepth 1 -type d -name "slapd-*" | xargs -n 1 basename); do
    for nsdb in $(find /var/lib/dirsrv/${dir}/db/ -mindepth 1 -maxdepth 1 -type d | xargs -n 1 basename); do
      ns-slapd db2ldif -D /etc/dirsrv/${dir} -n ${nsdb} \
        -a ${BACKUP_DIR}/$(hostname)-$(echo ${dir} | sed -e 's/slapd-//g')-${nsdb}.ldif \
        || die "Error backing up LDAP database: ${nsdb}"
    done
  done

elif [ "${PHASE}}" == "--after" ]; then
    rm -rf ${BACKUP_DIR}/*.ldif
fi
