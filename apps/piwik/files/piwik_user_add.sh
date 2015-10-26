#!/bin/bash

function die {
  echo 1>&2 "${1}"
  exit 1
}

DBNAME="${1}"
LOGIN="${2}"
PASSWORD=$(echo -n "${3}" | md5sum | awk '{print $1}')
TOKEN_AUTH=$(echo -n "${LOGIN}${PASSWORD}" | md5sum | awk '{print $1}')
EMAIL="${4}"
SUPERUSER="${5}"

MYSQL="mysql --defaults-file=$(cd ~root && pwd)/.my.cnf -s -u root ${DBNAME}"

found=$(echo "select count(*) from piwik_user where login='"${LOGIN}"'" | ${MYSQL} | tr -d ' ') || die "Error looking up user in piwik database"
if [[ ! -z "${found}" && ${found} -eq 0 ]] ; then
  echo "insert into piwik_user (login, password, alias, email, token_auth, superuser_access, date_registered)
        values ('"${LOGIN}"', '"${PASSWORD}"', '"${LOGIN}"', '"${EMAIL}"', '"${TOKEN_AUTH}"',
        ${SUPERUSER}, '"$(date "+%Y-%m-%d %H:%M:%S")"');" \
  | ${MYSQL} || die "Error adding mysql user to piwik database: ${LOGIN}"
else
  echo "user already exists: ${LOGIN}"
fi