#!/usr/bin/env bash

# To create php-atom, use phpbrew to build php but without the xdebug extension.
# Then rsync .phpbrew/php/php-<version> to .phpbrew/php/php-atom.
# Make sure Atom package configs also point to .phpbrew/php/php-atom.
exec /bin/bash -ic "loader rvm nvm node phpbrew composer && phpbrew use php-atom && exec /usr/bin/atom $*"
