#!/usr/bin/expect

set timeout 30
set hostname [lindex $argv 1]
set timezone [lindex $argv 0]
spawn setup-kolab

log_file -noappend /tmp/setup-kolab.expect.log

send_log ">>>>> Expecting Choice"

expect "Administrator password"
sleep 1
send "$::env(LDAP_PASS)\n"
sleep 1
send "$::env(LDAP_PASS)\n"

expect "Directory Manager password"
sleep 1
send "$::env(DIRMAN_PASS)\n"
sleep 1
send "$::env(DIRMAN_PASS)\n"

expect "User"
sleep 1
send "\n"
expect "Group"
sleep 1
send "\n"

expect "[Y/n]:"
sleep 1
send "n\n"
expect "Domain name to use:"
send "$hostname\n"
expect "[Y/n]:"
send "Y\n"

expect "Choice:"
send "1\n"

send_log ">>>>> Expecting MySQL root password"
expect "MySQL root password:"
send "$::env(MYSQL_PWD)\n"

send_log ">>>>> Expecting MySQL kolab password"
expect "MySQL kolab password"
sleep 1
send "$::env(KOLAB_PASS)\n"
sleep 1
send "$::env(KOLAB_PASS)\n"

send_log ">>>>> Expecting Timezone ID"
expect "Timezone ID"
sleep 1
send "$timezone\n"

send_log ">>>>> Expecting MySQL roundcube password"
expect "MySQL roundcube password"
sleep 1
send "$::env(RC_PASS)\n"
sleep 1
send "$::env(RC_PASS)\n"

set timeout 30
send_log ">>>>> Expecting EOF with timeout = 30"
expect eof

send_log ">>>>> DONE!"
exit 0
