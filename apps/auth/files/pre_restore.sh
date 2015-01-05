#!/bin/bash

backup_dir="${1}"
if [ -z "${backup_dir}" ] ; then
  echo "No backup dir specified"
  exit 1
fi

if [ $(service slapd status | grep running | wc -l) -gt 0 ] ; then
  service slapd stop
fi

# slapadd -F /etc/ldap/slapd.d -n 0 -l ${backup_dir}/config.ldif
slapadd -F /etc/ldap/slapd.d -n 1 -l ${backup_dir}/data.ldif
