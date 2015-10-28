#!/bin/bash

# Ensure jenkins user is in the 'docker' group
if [ $(id -Gn jenkins | grep docker | wc -l) -eq 0 ] ; then
  usermod -G docker jenkins || exit 1
fi
