#!/bin/bash
# Scripts used to stop the app
name=$1
port=$2

kill -9 `ps aux | grep -v grep | grep "\-p $port" | awk '{ print $2 }'`
