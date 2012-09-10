<?php
$dev_server = preg_replace('/:.*/',"", $_SERVER['HTTP_HOST']);

define('WP_SITEURL', "http://$dev_server");
define('WP_HOME', "http://$dev_server");

$WP_ENVIRONMENT = array(
	'db_name' => '',
	'db_user' => 'root',
	'db_password' => '',
	'db_host' => 'localhost',
	'wp_lang' => '',
	'wp_debug' => true
);
?>