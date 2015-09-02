#!/bin/bash

BASE=$(cd $(dirname $0) && pwd)
SERVER_TYPE="${1:?no server_type specified}"

INIT=cloudos-dns-rooty
ETC_INIT="/etc/init.d/${INIT}"

if [[ ${SERVER_TYPE} == "djbdns" ]] ; then
  cp "${BASE}/${INIT}" ${ETC_INIT}
  chmod 700 ${ETC_INIT}
  service cloudos-dns-rooty restart
fi
