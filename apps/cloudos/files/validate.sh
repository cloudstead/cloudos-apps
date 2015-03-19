#!/bin/bash

if [ $(netstat -nlpt | grep '/dovecot' | grep :143 | wc -l) -eq 0 ] ; then
  service dovecot start
fi
if [ $(netstat -nlpt | grep '/master' | grep ':25' | wc -l) -eq 0 ] ; then
  service postfix restart
fi
if [ $(service cloudos status | grep "is running" | wc -l) -eq 0 ] ; then
  service cloudos restart
fi
