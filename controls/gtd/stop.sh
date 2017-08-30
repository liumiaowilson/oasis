#!/bin/bash
# Scripts used to stop the app
app=$1
port=$2
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app

kill -9 `ps aux | grep -v grep | grep "\--server $port" | awk '{ print $2 }'`
