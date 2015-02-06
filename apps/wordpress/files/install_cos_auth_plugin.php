#!/usr/bin/php5
<?php

$base = $argv[1];

require_once( $base . "/wp-load.php" );
require_once(  $base . "/wp-admin/includes/plugin.php");

activate_plugin($base . "wp-content/plugins/cos_auth.php");

?>