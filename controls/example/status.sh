#!/bin/bash
# Scripts used to query the app status
name=$1
port=$2

ps aux | grep -v grep | grep -q "\-p $port"
if [[ $? -ne 0 ]]; then
    exit 1
else
    exit 0
fi
