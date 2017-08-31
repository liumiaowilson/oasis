#!/bin/bash
# Scripts used to start the app
app=$1
port=$2
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app
log=$dataHome/server.log
wikiData=$dataHome/data

if [[ -f $dataHome/env.sh ]];then
    source $dataHome/env.sh
else
    echo "env.sh should be provided."
    exit 1
fi

nohup $appHome/tiddlywiki.js $wikiData --server $port $:/core/save/lazy-all text/plain text/html "$wiki_username" "$wiki_password" 0.0.0.0 > $log 2>&1 &
