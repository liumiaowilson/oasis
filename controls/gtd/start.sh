#!/bin/bash
# Scripts used to start the app
app=$1
port=$2
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app
log=$dataHome/server.log
gtdData=$dataHome/data
wikiAppHome=$OASIS_HOME/apps/wiki
wikiDataHome=$OASIS_HOME/data/wiki

if [[ -f $dataHome/env.sh ]];then
    source $dataHome/env.sh
else
    echo "env.sh should be provided."
    exit 1
fi

nohup $wikiAppHome/tiddlywiki.js $gtdData --load $appHome/cardo.html --server $port $:/core/save/all text/plain text/html "$gtd_username" "$gtd_password" 0.0.0.0 > $log 2>&1 &
