#!/bin/bash

vboxmanage list --long vms | egrep "State|^Name:"
