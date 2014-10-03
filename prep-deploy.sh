#!/bin/bash

BASE=$(cd $(dirname $0) && pwd)

../cloudos-appstore/bin/cbundle ${BASE}/apps && ${BASE}/consolidate-cookbooks.sh 1>&2
