#!/bin/bash

ENABLED=/etc/apache2/sites-enabled
roots="$(find ${ENABLED} | egrep -v "sites-enabled$" | xargs -n 1 egrep -l -- '<VirtualHost\s+.+:[[:digit:]]+\s*>' | xargs egrep -l "^\s*ServerName\s*$(hostname)\s*")"

for config in ${roots} ; do
  if [ $(basename ${config}) != "apache-root.conf" ] ; then
    echo "Refusing to override existing web root config: ${config}"
    exit 1
  fi
done