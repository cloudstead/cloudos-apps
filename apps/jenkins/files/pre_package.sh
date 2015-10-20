#!/bin/bash

function die {
  echo 1>&2 "${1}"
  exit 1
}

if [ "$(whoami)" != "root" ] ; then
  die "Not root"
fi

if [ $(apt-key list | grep "Kohsuke Kawaguchi" | wc -l | tr -d ' ') -eq 0 ] ; then
  wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - || die "Error adding jenkins key"
fi

APT_SOURCES="/etc/apt/sources.list"
if [ $(cat ${APT_SOURCES} | grep "deb http://pkg.jenkins-ci.org/debian binary/" | wc -l | tr -d ' ') -eq 0 ] ; then
  echo "deb http://pkg.jenkins-ci.org/debian binary/" >> ${APT_SOURCES}
  apt-get update
fi
