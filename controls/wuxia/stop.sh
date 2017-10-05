#!/bin/bash
# Scripts used to stop the app
app=$1
port=$2
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app
log=$dataHome/server.log
gameHome=$dataHome/game

old_pwd=`pwd`

source ~/envs/wuxia/bin/activate
cd $gameHome
nohup muddery stop > $log

cd $old_pwd
