#!/usr/bin/expect

set timeout 10
spawn gpg --keyserver pgp.mit.edu --search devel@lists.kolab.org

expect "Q)uit > "

send "1\n"

expect eof

exit 0

