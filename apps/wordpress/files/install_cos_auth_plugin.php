#!/usr/bin/php5
<?php

$base = $argv[1];

require_once( $base . "/wp-load.php" );
require_once(  $base . "/wp-admin/includes/plugin.php");

$plugin_path = $base . "/wp-content/plugins/cos_auth.php";

$rval = activate_plugin($plugin_path);
if (null == $rval) {
    fwrite(STDOUT, "successfully activated plugin: $plugin_path\n");
    exit(0);

} else {
    fwrite(STDERR, "error activating plugin: " . print_r($rval, 1) . "\n");
    exit(1);
}

?>