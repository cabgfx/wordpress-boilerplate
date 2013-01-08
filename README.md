# WordPress Boilerplate - WPBP

WPBP simplifies the process of setting up, and working with, WordPress, taking care of tedious grunt work so you can hit the ground running.

WPBP consists of three distinct components:

* A script to setup a new WP install from the latest, stable WordPress package, automagically configured for you, including the following:
* Simple tools to enable easy portability between different environments, eg. development, staging, production.
Maintained at [cabgfx/wpbp-config][conf].
* **STILL IN THE WORKS** A basic starter theme, with a narrow focus on template organization and utility functions, **not** markup and styling. (A cross-breed of [Starkers][st] and [Roots][ro]).
Maintained at [cabgfx/wpbp-theme][theme].

[conf]: https://github.com/cabgfx/wpbp-config
[theme]: https://github.com/cabgfx/wpbp-theme
[st]: https://github.com/viewportindustries/starkers
[ro]: https://github.com/retlehs/roots

## Set up a new WP site

Create a new directory for your site and open it
```bash
mkdir my-new-site && cd my-new-site
```

Install all components of WPBP (Might take a minute or two, depending on your internet connection).
```bash
curl -L get.wbp.io | sh
```

Note: get.wbp.io redirects to the latest stable version of the install script on github, hence the `-L` flag – here's the source: [cabgfx/wordpress-boilerplate/master/install.sh](https://raw.github.com/cabgfx/wordpress-boilerplate/master/install.sh)

Finally, add your environment details. Here's an example from my development setup:

```php
<?php
// config/environments/development.php

...

$WP_ENVIRONMENT = array(
  'db_name' => 'my_dummy_db',
  'db_user' => 'root',
  'db_password' => 's00pAzeekret',
  'db_host' => 'localhost',
  'wp_lang' => 'da_DK', // You must add language files yourself.
  'wp_debug' => true,
  'name' => 'development' // Used to check current environment, see note below about environment-specific stuff.
);
?>
```

## Use the tools on existing sites

If you already have a WordPress install, and just need to add support for multiple environments, you only need the wpbp-config package. See the repository at [cabgfx.com/wpbp-config][conf] for details.

## Work with multiple environments

Using WPBP, you (and your team) can develop locally on `localhost` or anything else, and deploy the same codebase to `staging.yoursite.com`.

It's common to restore a database on each of your various (test-)environments, eg. local, staging etc.
However, [WordPress serves pages with embedded absolute URLs based on the absolute site URL configured in your database] [docs], which is not ideal.
Normally, you'd have to manually update two options in the DB on each environment to set the correct hostname.

**WPBP eliminates this by overriding `WP_SITEURL` and `WP_HOME`.**

[docs]: http://codex.wordpress.org/Running_a_Development_Copy_of_WordPress

##### A note about production
`config/environments/production.php` is by default set up to not override the constants, deriving the URL straight from the database. If this is not what you want, you can easily do it yourself — just check `development.php`, for instance.

## Automatic configuration of `wp-config.php`

Installing new WP sites requires you to rename `wp-config-sample.php` and get a fresh set of security keys for the WP backend. WPBP handles that for you, automatically renaming the file and inserting a fresh set of keys, straight from [the online generator][gen]. Neat, huh?

[gen]: https://api.wordpress.org/secret-key/1.1/salt/

## Git-ready

A template `.gitignore` is also provided for you, so you don't have to manually ignore the core WP files. You just need to add your own themes/plugins etc., as you create them.

## A helper for environment-specific stuff

WPBP defines an additional constant, `WPBP_ENV`, which enables you to easily check what environment you're running in.

Example:
I usually don't want to include the Google Analytics script when I work locally, so here's what I do:

```php
<?php if (WPBP_ENV == 'production'): ?>
  <script> … </script>
<?php endif; ?>
```

## Adding more environments
Initially, two environments are setup for you - development and production. Let's say you want to add a staging environment:

1. Duplicate an existing environment file and rename it to something else, eg. `staging.php`.
2. Update `staging.php` with your details.
3. Update `config/bootstrap.php` to load the staging config, given a certain condition (typically just a specific domain):

```php
<?php
// Development
if ($_SERVER['REMOTE_ADDR']=='127.0.0.1') {
  require_once 'environments/development.php';

// Staging
} elseif ($_SERVER['REMOTE_ADDR']=='X.X.X.X') {
  require_once 'environments/staging.php';

// Production
} else {
  require_once 'environments/production.php';
}
?>
```
