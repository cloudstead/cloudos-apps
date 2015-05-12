#!/bin/bash

BACKUP_DIR="${1}"
if [ -z "${BACKUP_DIR}" ] ; then
  echo "No backup dir specified"
  exit 1
fi

FILES_DIR=${BACKUP_DIR}/tmp

rec=""
while read line ; do
  if [ $(echo -n ${line} | tr -d [[:blank:]] | wc -c) -eq 0 ] ; then
    echo "${rec}" | slapadd -F /etc/ldap/slapd.d -n 1 -l ${FILES_DIR}/data.ldif || echo "Error adding record: ${rec}"
    rec=""
  else
    if [ -z "${rec}" ] ; then
      rec="${line}"
    else
      rec="${rec}
${line}"
    fi
  fi
done < ${FILES_DIR}/data.ldif

# Unlikely, but just in case the ldif file does not end with a blank line...
if [ ! -z "${rec}" ] ; then
  echo "${rec}" | slapadd -F /etc/ldap/slapd.d -n 1 -l ${FILES_DIR}/data.ldif || echo "Error adding record: ${rec}"
fi

# slapadd -F /etc/ldap/slapd.d -n 1 -l ${FILES_DIR}/data.ldif
