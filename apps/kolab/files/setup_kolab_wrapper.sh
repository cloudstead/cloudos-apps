#!/bin/bash

function die {
  echo 1>&2 "${1}"
  exit 1
}

BASE=$(cd $(dirname $0) && pwd)
MARKER_FILE=/etc/kolab/.setup.complete
LOG=/tmp/setup-kolab.log

if [ ! -f ${MARKER_FILE} ] ; then
  ${BASE}/setup_kolab_expect.sh $@ 2>&1 > ${LOG} && touch ${MARKER_FILE} || die "Error running setup-kolab"
  rm ${LOG}
fi

# clean up Apache configs
KOLAB_WEBAPPS="chwala iRony kolab-freebusy kolab-syncroton kolab-webadmin roundcubemail"
APACHE="/etc/apache2"
SVC_AVAIL="${APACHE}/https-services-available"
SVC_ENABLED="${APACHE}/https-services-enabled"
SITE_AVAIL="${APACHE}/sites-available"
SITE_ENABLED="${APACHE}/sites-enabled"

for service in ${KOLAB_WEBAPPS} ; do

  kolab_installed="${SITE_AVAIL}/${service}.conf"
  avail="${SVC_AVAIL}/${service}"

  if [ ! -e "${avail}" ] ; then
    if [ -e "${kolab_installed}" ] ; then
       mv "${kolab_installed}" "${SVC_AVAIL}" || die "Error moving ${kolab_installed} -> ${SVC_AVAIL}"
       cd ${SVC_ENABLED}
       ln -s ../https-services-available/${service}.conf || die "Error creating symlink for ${service} in ${SVC_ENABLED}"
       cd -
    else
      echo "${kolab_installed} not found, skipping"
    fi
  fi

  # Remove obsolete files if they exist
  if [[ -e "${kolab_installed}" || -L "${kolab_installed}" ]] ; then
    rm "${kolab_installed}" || die "Error removing ${kolab_installed}"
  fi
  if [[ -e "${SITE_ENABLED}/${service}.conf" || -L "${SITE_ENABLED}/${service}.conf" ]] ; then
    rm "${SITE_ENABLED}/${service}.conf" || die "Error removing ${SITE_ENABLED}/${service}.conf"
  fi

done

# write "shim" config so that kolab paths will bypass any proxy on the document root
if [ ! -e "${SVC_ENABLED}/kolab-shim" ] ; then
  KOLAB_SHIM="${SVC_AVAIL}/kolab-shim"
  cat /dev/null > "${KOLAB_SHIM}"
  for service in ${KOLAB_WEBAPPS} ; do
    echo "ProxyPass /${service} !" >> "${KOLAB_SHIM}" || die "Error writing to ${KOLAB_SHIM}"
  done
  cd ${SVC_ENABLED}
  ln -sf ../https-services-available/kolab-shim || die "Error creating symlink for kolab-shim in ${SVC_ENABLED}"
  cd -
fi
