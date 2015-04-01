#!/bin/bash

DOMAIN="${1}"

openssl req -nodes -newkey rsa:2048 -sha1 -keyout ${DOMAIN}.key -out ${DOMAIN}.csr