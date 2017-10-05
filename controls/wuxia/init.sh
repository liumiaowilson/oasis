#!/bin/bash
# Scripts used to initialize the app
app=$1
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app
gameHome=$dataHome/game

cd $appHome && git submodule update --init --recursive

mkdir -p $dataHome

cp $controlHome/env.sh $dataHome/env.sh
echo "*** Please update [$dataHome/env.sh] ***"

mkdir -p ~/envs/wuxia
virtualenv ~/envs/wuxia
source ~/envs/wuxia/bin/activate

old_pwd=`pwd`

cd $appHome
pip install -e .
muddery --init $gameHome example

cp $controlHome/settings.py $gameHome/server/conf/

cd $gameHome
muddery -i start

cd $old_pwd
