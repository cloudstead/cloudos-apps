#!/bin/bash

BASE=$(cd $(dirname $0) && pwd)
COOKBOOKS=./chef-repo/cookbooks/

cd ${BASE}

rm -rf ${COOKBOOKS}
mkdir -p ${COOKBOOKS}

rsync -avzc ../cloudos-lib/${COOKBOOKS}* ${COOKBOOKS}

for cookbooks in $(find $(find apps -type d -name target) -type d -name cookbooks) ; do
  rsync -avzc ${cookbooks}/* ${COOKBOOKS}
done
