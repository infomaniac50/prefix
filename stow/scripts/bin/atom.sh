#!/usr/bin/env bash

exec /bin/bash -ic "loader rvm nvm node phpbrew composer && exec /usr/bin/atom $*"
