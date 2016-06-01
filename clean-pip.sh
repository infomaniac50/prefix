#!/bin/bash

python -m pip list --user | cut -f1 -d' ' | xargs python -m pip uninstall -y
