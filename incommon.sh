#!/bin/sh

for package in $@
do
    pactree -u $package
    echo ---
done
