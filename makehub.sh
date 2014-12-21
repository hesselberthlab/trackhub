#! /usr/bin/env bash

hubdir=$HOME/public_html/hubs/public

if [[ -d $hubdir ]]; then
    rm -rf ~/public_html/hubs/public/
fi

mkdir $hubdir
cp -r * $hubdir

hubCheck -verbose=2 http://amc-sandbox.ucdenver.edu/~jhessel/hubs/public/hub.txt

