#!/usr/bin/expect

set timeout 30
set hostname [lindex $argv 0]
set timezone [lindex $argv 1]
spawn setup-kolab

log_file -noappend /tmp/setup-kolab.expect.log

expect "Administrator password"
sleep 0.25
send "$::env(LDAP_PASS)\n"
sleep 0.25
send "$::env(LDAP_PASS)\n"

expect "Directory Manager password"
sleep 0.25
send "$::env(DIRMAN_PASS)\n"
sleep 0.25
send "$::env(DIRMAN_PASS)\n"

expect "User"
sleep 0.25
send "\n"
expect "Group"
sleep 0.25
send "\n"

expect "\[Y/n]:"
sleep 0.25
send "n\n"

expect "Domain name to use:"
sleep 0.25
send "$hostname\n"

expect "\[Y/n]:"
sleep 0.25
send "Y\n"

sleep 20
set timeout 120
expect "Cyrus Administrator password"
sleep 0.25
send "$::env(CYRUS_PASS)\n"
sleep 0.25
send "$::env(CYRUS_PASS)\n"

expect "Kolab Service password"
sleep 0.25
send "$::env(KOLAB_SVC_PASS)\n"
sleep 0.25
send "$::env(KOLAB_SVC_PASS)\n"

expect "Choice:"
sleep 0.25
send "1\n"

expect "MySQL root password:"
send "$::env(MYSQL_PWD)\n"

expect "MySQL kolab password"
sleep 0.25
send "$::env(KOLAB_PASS)\n"
sleep 0.25
send "$::env(KOLAB_PASS)\n"

expect "Timezone ID"
sleep 0.25
send "$timezone\n"

expect "MySQL roundcube password"
sleep 0.25
send "$::env(RC_PASS)\n"
sleep 0.25
send "$::env(RC_PASS)\n"

set timeout 30
expect eof

exit 0
