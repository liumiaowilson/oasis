#!/bin/bash
# Scripts used to initialize the app
app=$1
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app

mkdir -p $dataHome
