#!/bin/bash
# Scripts used to start the app
app=$1
port=$2
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app
log=$dataHome/server.log

nohup http-server $appHome -p $port > $log 2>&1 &
