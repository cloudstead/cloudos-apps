#!/usr/bin/php5
<?php
$base = $argv[1];
include($base . '/wp-config.php');
include($base . '/wp-includes/pluggable.php');
fwrite(STDOUT, wp_hash_password($argv[2]));
?>