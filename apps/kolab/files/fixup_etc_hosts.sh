#!/bin/bash

# Remove entries from /etc/hosts that have the same short-hostname as the full hostname.
# They will mess up the setup-kolab script.
temp_hosts=$(mktemp /tmp/hosts.XXXXXXX) || die "Error creating temp hosts file"
cat /etc/hosts > ${temp_hosts} || die "Error backing up hosts file"

cat /etc/hosts | egrep '^[^ ]+\s+[^.]+$' | grep -v ip6 | grep -v localhost | while read line ; do
  tmp=$(mktemp /tmp/hosts.XXXXXXX) || die "Error creating temp hosts file"
  cat ${temp_hosts} | grep -v "${line}" > ${tmp} || die "Error writing hosts file"
  mv ${tmp} ${temp_hosts}
done
cp /etc/hosts /etc/hosts.backup_$(date +%s)
mv ${temp_hosts} /etc/hosts
