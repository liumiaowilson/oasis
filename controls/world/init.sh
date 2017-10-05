#!/bin/bash
# Scripts used to initialize the app
app=$1
appHome=$OASIS_HOME/apps/$app
controlHome=$OASIS_HOME/controls/$app
dataHome=$OASIS_HOME/data/$app

cd $appHome && git submodule update --init --recursive

mkdir -p $dataHome
ln -s $appHome/data $dataHome/data

cp $controlHome/env.sh $dataHome/env.sh
echo "*** Please update [$dataHome/env.sh] ***"

old_pwd=`pwd`

cd $appHome
npm install
npm run bundle-install

cd $old_pwd
