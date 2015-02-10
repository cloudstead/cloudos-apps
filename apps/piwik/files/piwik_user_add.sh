#!/bin/bash

DBNAME="${1}"
LOGIN="${2}"
PASSWORD=$(echo -n "${3}" | md5sum | awk '{print $1}')
TOKEN_AUTH=$(echo -n "${LOGIN}${PASSWORD}" | md5sum | awk '{print $1}')
EMAIL="${4}"
SUPERUSER="${5}"

found=$(echo "select count(*) from piwik_user where login='"${LOGIN}"'" | mysql -s -u root ${DBNAME} | tr -d ' ')
if [[ ! -z "${found}" && ${found} -eq 0 ]] ; then
  echo "insert into piwik_user (login, password, alias, email, token_auth, superuser_access, date_registered)
        values ('"${LOGIN}"', '"${PASSWORD}"', '"${LOGIN}"', '"${EMAIL}"', '"${TOKEN_AUTH}"',
        ${SUPERUSER}, '"$(date "+%Y-%m-%d %H:%M:%S")"');" \
  | mysql -u root ${DBNAME}
else
  echo "user already exists: ${LOGIN}"
fi