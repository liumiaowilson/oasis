#!/bin/bash
# Scripts used to query the app status
app=$1
port=$2
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app

ps aux | grep -v grep | grep -q "\--server $port"
if [[ $? -ne 0 ]]; then
    exit 1
else
    exit 0
fi
