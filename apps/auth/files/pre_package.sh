#!/bin/bash

if [ -f /etc/krb5kdc/setup.marker ] ; then
  echo "$(date): marker file exists, skipping $0 $@" 2>&1 | tee -a /tmp/kerb.log
else

echo "$(date): started $0 $@" >> /tmp/kerb.log

mv /etc/hosts /etc/hosts.bak && echo "127.0.0.1 localhost
127.0.1.1 $(hostname)" > /etc/hosts

echo "$(date): completed $0 $@" >> /tmp/kerb.log

fi