#!/bin/bash
# Scripts used to start the app
app=$1
port=$2
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app
log=$dataHome/server.log
gameHome=$dataHome/game

if [[ -f $dataHome/env.sh ]];then
    source $dataHome/env.sh
else
    echo "env.sh should be provided."
    exit 1
fi

old_pwd=`pwd`

source ~/envs/wuxia/bin/activate
cd $gameHome
nohup muddery start > $log

cd $old_pwd
