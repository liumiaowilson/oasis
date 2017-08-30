#!/bin/bash
# Scripts used to start the app
name=$1
port=$2
cwd=$OASIS_HOME/apps/$name
log=$OASIS_HOME/data/$name/server.log

nohup http-server $cwd -p $port > $log 2>&1 &
