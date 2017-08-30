#!/bin/bash
# Scripts used to initialize the app
app=$1

if [[ "$app" == "" ]];then
    echo "App name is required."
    exit 1
fi

mkdir -p $OASIS_HOME/data/$app
