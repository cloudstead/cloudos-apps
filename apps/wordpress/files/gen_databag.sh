#!/bin/bash

LOGIN=${1}
PASSWORD=${2}
EMAIL=${3}

THISDIR=$(cd $(dirname $0) && pwd)

cos config -a jonathan -n wordpress -r $(cos json ${THISDIR}/../cloudos-manifest.json) -c \
'{"categories":[{"name":"init", "values":{"admin.login":"'${LOGIN}'", "admin.password":"'${PASSWORD}'", "admin.email":"'${EMAIL}'"}}]}'
