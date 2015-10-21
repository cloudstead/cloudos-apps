#!/bin/bash

function die {
  echo 1>&2 "${1}"
  exit 1
}

login=${1?:no login provided}
password=${2?:no password provided}
email=${3?:no email provided}
full_name=${4?:no fullname provided}

USER_XML="/var/lib/jenkins/users/${login}/config.xml"
if [ -f ${USER_XML} ] ; then
  echo "User file already exists: ${USER_XML}"
  exit 0
fi

cookie_jar=$(mktemp /tmp/setup_admin_cookies.XXXXXXX) || die "Error creating cookie jar"

# check for digest auth in apache-root, if configured
BASE=$(cd $(dirname $0) && pwd) # this should be ..../chef/cookbooks/jenkins/files/default
APACHE_ROOT_INIT="${BASE}/../../../../data_bags/apache-root/init.json"
CURL_OPTS="-c ${cookie_jar}"
if [ -f ${APACHE_ROOT_INIT} ] ; then
  JSON="${BASE}/../../../../JSON.sh"
  http_user=$(cat ${APACHE_ROOT_INIT} | ${JSON} | grep '\["digest_auth","user"\]' | awk '{print $2}' | tr -d '"')
  http_password=$(cat ${APACHE_ROOT_INIT} | ${JSON} | grep '\["digest_auth","password"\]' | awk '{print $2}' | tr -d '"')
  CURL_OPTS="${CURL_OPTS} --digest --user ${http_user}:${http_password}"
fi

status="$(curl ${CURL_OPTS} -sL -w "%{http_code}" --max-time 10 "https://$(hostname)/jenkins" -o /dev/null | head -c 1)"
start=$(date +%s)
TIMEOUT=600
apache_restarted=0
while [[ -z "${status}" || ${status} -ne 2 ]] ; do
  sleep 10s
  status="$(curl ${CURL_OPTS} -sL -w "%{http_code}" --max-time 10 "https://$(hostname)/jenkins" -o /dev/null | head -c 1)"
  if [[ $(expr $(date +%s) - ${start}) -gt 90 && ${apache_restarted} -eq 0 ]] ; then
    service apache2 restart
    apache_restarted=1
  fi
  if [[ $(expr $(date +%s) - ${start}) -gt ${TIMEOUT} ]] ; then
    die "Timed out waiting for Jenkins to start"
  fi
done

temp_page=$(mktemp /tmp/setup_admin_page.XXXXXXX) || die "Error creating temp file for HTML pages"
curl ${CURL_OPTS} https://$(hostname)/jenkins/securityRealm/firstUser > ${temp_page}
if [ $? -ne 0 ] ; then
  echo "Error getting first user page"
  rm -f ${temp_page} ${cookie_jar}
  exit 1
fi

crumb=$(cat ${temp_page} | egrep -o '"\.crumb", "[[:alnum:]]+"' | tr -d ',"' | awk '{print $2}')

curl -X POST ${CURL_OPTS} \
  --data-urlencode "username=${login}" \
  --data-urlencode "password1=${password}" \
  --data-urlencode "password2=${password}" \
  --data-urlencode "fullname=${full_name}" \
  --data-urlencode "email=${email}" \
  --data-urlencode ".crumb=${crumb}" \
  --data-urlencode "json={\"username\":\"${login}\",\"password1\":\"${password}\",\"password2\":\"${password}\",\"fullname\":\"${full_name}\",\"email\":\"${email}\",\"crumb\":\"${crumb}\"}" \
  --data-urlencode "Submit=Sign up" \
https://$(hostname)/jenkins/securityRealm/createFirstAccount
curl_ok=$?

rm -f ${temp_page} ${cookie_jar}

if [ ${curl_ok} -ne 0 ] ; then
  die "Error creating first account"
fi
