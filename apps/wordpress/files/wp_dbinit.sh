#!/bin/bash

DBNAME=$1
DBUSER=$2
DBPASS=$3
WP_PASS=$4
DOC_ROOT=$5
LOGIN=$6
PASS="${7}"
EMAIL=$8
TSTAMP=$9

ROW_COUNT=$(echo "SELECT COUNT(*) FROM wp_users" | mysql -s -u ${DBUSER} ${DBNAME} -p${DBPASS} 2> /dev/null)

if [[ ! -z "${ROW_COUNT}" && ${ROW_COUNT} -eq 0 ]] ; then

  HASHED_PASS="$(${WP_PASS} ${DOC_ROOT} ${PASS})"

  echo "INSERT INTO wp_users VALUES (1,'${LOGIN}','${HASHED_PASS}','${LOGIN}','${EMAIL}','','${TSTAMP}','',0,'${LOGIN}')" \
    | mysql -u ${DBUSER} ${DBNAME} -p${DBPASS}

fi
