# WordPress Boilerplate

  
WPBP is a set of small, simple tools for local WordPress development on a Mac. It installs and automagically configures the latest, stable WP release, straight off wordpress.org. Add your database info, and you're ready to serve up the site on any hostname, independent of environment and database.


Here's how it works:

![Alt text](https://s3-eu-west-1.amazonaws.com/wordpress-boilerplate/wpbp-install-demo.gif "Animated GIF showing the install procedure on the command line")

(note the url for install has changed, see “How to install” below.)

## How to install

Create a directory for your site and open it
```bash
mkdir my-new-site && cd my-new-site
```

Install all components of WPBP (Might take a minute or two, depending on your internet connection).
```bash
curl -L https://raw.githubusercontent.com/cabgfx/wordpress-boilerplate/master/install.sh | sh
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
  'name' => 'development' // Used to check current environment, see note about environment-specific stuff.
);
?>
```

## What's included

**Installation script for new sites**

A script to download and configure WP, automatically setting up keys for the WP backend, Git revision control and utilities to work with multiple environments. The script is maintained in this project, but you run it from the terminal by CURL'ing the install script from GitHub. See “How to install” for full instructions.

**Configuration files for new and existing sites**

Abstractions to the base WP configuration in `wp-config.php`, enabling the use of multiple environments for easier team collaboration and code portability (think development > staging > production), independent of database configuration. Maintained at [cabgfx/wpbp-config][conf]

**Starter theme**

Maintained at [cabgfx/wpbp-theme][theme] _Note that the theme isn't included in the install script (yet)._

[conf]: https://github.com/cabgfx/wpbp-config
[theme]: https://github.com/cabgfx/wpbp-theme
[st]: https://github.com/viewportindustries/starkers
[ro]: http://roots.io/

## Why should I use this?

Using these tools to set up new WP sites gives you:

**Automatic configuration of `wp-config.php`**

Installing new WP sites requires you to rename `wp-config-sample.php` and get a fresh set of security keys for the WP backend. WPBP handles that for you, automatically renaming the file and inserting a fresh set of keys, straight from [the online generator][gen]. Neat, huh?

[gen]: https://api.wordpress.org/secret-key/1.1/salt/

**Multiple environments**

Using WPBP, you (and your team) can develop locally on `localhost`, and deploy the same codebase to other locations, eg. `www.yoursite.com`, which is notoriously cumbersome, because of how WP sets up the hostname in the database. Additional details can be found in the [wpbp-config repo][conf].

**A helper for environment-specific stuff**

WPBP defines an additional constant, `WPBP_ENV`, which enables you to easily check what environment you're running in.

Example:
I usually don't want to include the Google Analytics script when I work locally, so here's what I do:

```php
<?php if (WPBP_ENV == 'production'): ?>
  <script> … </script>
<?php endif; ?>
```

**Git-ready project setup**

A template `.gitignore` is provided for you, so you don't have to manually ignore the core WP files. You just need to add your own themes/plugins etc., as you create them.

## Caveats

* Multisite support is not included by default, but you can add it manually. [More info in this wiki entry](https://github.com/cabgfx/wordpress-boilerplate/wiki/Multisite-support).
* Mac OS X only. Contributions to add more platforms are welcome, but I have no intentions to make them myself.

## Using these tools on pre-existing sites

If you already have a WordPress install, and just need to add support for multiple environments, you only need the wpbp-config package. See the repository at [cabgfx/wpbp-config][conf] for details.
