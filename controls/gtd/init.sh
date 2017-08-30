#!/bin/bash
# Scripts used to initialize the app
app=$1
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app
gtdData=$dataHome/data
wikiAppHome=$OASIS_HOME/apps/wiki
wikiDataHome=$OASIS_HOME/data/wiki

# GTD depends on wiki
if [[ ! -f $wikiDataHome/env.sh ]];then
    echo "*** [wiki] should be installed before [gtd] ***"
    exit -1
fi

mkdir -p $gtdData

cp $controlHome/env.sh $dataHome/env.sh
echo "*** Please update the credentials at [$dataHome/env.sh] ***"

$wikiAppHome/tiddlywiki.js $gtdData --init server
