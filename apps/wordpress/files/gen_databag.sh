#!/bin/bash

LOGIN=admin
PASSWORD=foo
EMAIL=jonathan@kyuss.org
cos config -a jonathan -n wordpress -r 0.1.0 -c \
'{"categories":[{"name":"init", "values":{"admin.login":"'${LOGIN}'", "admin.password":"'${PASSWORD}'", "admin.email":"'${EMAIL}'"}}]}'
