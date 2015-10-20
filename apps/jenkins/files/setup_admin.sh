#!/bin/bash

function die {
  echo 1>&2 "${1}"
  exit 1
}

login=${1?:no login provided}
password=${2?:no password provided}
email=${3?:no email provided}
full_name=${4?:no fullname provided}

cookie_jar=$(mktemp /tmp/setup_admin_cookies.XXXXXXX) || die "Error creating cookie jar"

status="$(curl -sL -w "%{http_code}" --max-time 10 "https://$(hostname)/jenkins" -o /dev/null | head -c 1)"
start=$(date +%s)
TIMEOUT=300
while [[ -z "${status}" || ${status} -ne 2 ]] ; do
  sleep 2s
  status="$(curl -sL -w "%{http_code}" --max-time 10 "https://$(hostname)/jenkins" -o /dev/null | head -c 1)"
  if [[ $(expr $(date +%s) - ${start}) -gt ${TIMEOUT} ]] ; then
    die "Timed out waiting for Jenkins to start"
  fi
done

temp_page=$(mktemp /tmp/setup_admin_page.XXXXXXX) || die "Error creating temp file for HTML pages"
curl -c ${cookie_jar} https://$(hostname)/jenkins/securityRealm/firstUser > ${temp_page}
if [ $? -ne 0 ] ; then
  echo "Error getting first user page, perhaps an admin is already set up?"
  rm -f ${temp_page} ${cookie_jar}
  exit 0
fi

crumb=$(cat ${temp_page} | egrep -o '"\.crumb", "[[:alnum:]]+"' | tr -d ',"' | awk '{print $2}')

curl -X POST \
  -c ${cookie_jar} \
  --data-urlencode 'username='"${login}"'' \
  --data-urlencode 'password1='"${password}"'' \
  --data-urlencode 'password2='"${password}"'' \
  --data-urlencode 'fullname='"${full_name}"'' \
  --data-urlencode 'email='"${email}"'' \
  --data-urlencode '.crumb='"${crumb}"'' \
  --data-urlencode 'json={"username":"'"${login}"'","password1":"'"${password}"'","password2":"'"${password}"'","fullname":"'"${full_name}"'","email":"'"${email}"'","crumb":"'"${crumb}"'"}' \
  --data-urlencode 'Submit=Sign+up' \
https://$(hostname)/jenkins/securityRealm/createFirstAccount
curl_ok=$?

rm -f ${temp_page} ${cookie_jar}

if [ ${curl_ok} -ne 0 ] ; then
  die "Error creating first account"
fi
