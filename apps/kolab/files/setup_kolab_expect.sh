#!/usr/bin/expect

set timeout 30
set conf [lindex $argv 0]
set timezone [lindex $argv 1]
spawn setup-kolab --with-openldap

log_file -noappend /tmp/setup-kolab.expect.log

send_log ">>>>> Expecting Choice"

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
