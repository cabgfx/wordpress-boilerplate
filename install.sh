#!/bin/sh
#
# Instructions:
# 
# First, create the directory where you want to install WordPress.
# 
# Then, `cd` into this newly created directory
#
# `curl -L get.wbp.io | sh` and watch magic unfold before you.

# Exit if we're not on OS X

if [ "$(uname -s)" != "Darwin" ]; then
  echo "Sorry, you need Mac OS X to run this." >&2
  exit 1
fi

echo "

*** Fetching latest WordPress... (hang on)"

# Get latest, stable WordPress package
curl -#o wordpress.zip http://wordpress.org/latest.zip

echo "

*** Unpacking WP..."

# Unzip the package and clean up files we don't need, including OSX-related cruft
unzip -q wordpress.zip
mv wordpress/* .

echo "

*** Cleaning up..."

rm -rf __MACOSX
rm -rf wordpress/
rm wordpress.zip
rm wp-config-sample.php

echo "

*** Configuring WP for local development..."

# Now, setup WP with a sane development environment
# First, get the latest package, and clean up when done
curl -#Lo master.zip https://github.com/cabgfx/wpbp-config/zipball/master
unzip -q master.zip
rm master.zip
mv cabgfx-wpbp-config*/* cabgfx-wpbp-config*/.[^.]* .
rm -rf cabgfx-wpbp-config*/
mv config/environments/development-sample.php config/environments/development.php

echo "

*** Installing secret keys for WP backend..."

# Get salted keys for WordPress backend, fresh from the source
curl -#o salt https://api.wordpress.org/secret-key/1.1/salt/
sed -i  '' -e "/define('DB_COLLATE/r salt" wp-config.php
rm salt

echo "

*** Setting up .gitignore template..."

# Setup .gitignore
mv gitignore-template .gitignore

echo "

*** All done!

Add your details to config/environments/development.php and you're all set.
Thanks,
Casper.

"

# Done. Now install your theme, etc. and enjoy local WordPress development without pains.
