#!/bin/bash

LOGIN="${1}"
PASSWORD="${2}"
EMAIL="${3}"
FULLNAME="${4}"
EMAIL_PREFIX="${5}"
APP_TITLE="${6}"
PUBLIC_SITE="${7}"

cos config -a jonathan -n jira -r 0.1.0 -c \
'{"categories":[{"name":"init",
  "values":{"email_prefix": "'${EMAIL_PREFIX}'",
            "title": "'${APP_TITLE}'",
            "public_site": "'${PUBLIC_SITE}'",
            "admin.login":"'${LOGIN}'",
            "admin.password":"'${PASSWORD}'",
            "admin.email":"'${EMAIL}'",
            "admin.fullname": "'${FULLNAME}'"}
}]}'
