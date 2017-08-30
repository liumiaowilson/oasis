#!/bin/bash
# Scripts used to initialize the app
app=$1
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app
wikiData=$dataHome/data

cd $appHome && git submodule update --init --recursive

mkdir -p $wikiData

cp $controlHome/env.sh $dataHome/env.sh
echo "*** Please update the credentials at [$dataHome/env.sh] ***"

$appHome/tiddlywiki.js $wikiData --init server
