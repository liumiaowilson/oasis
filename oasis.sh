#!/bin/bash
action=$1
target=$2

function helpApp {
    echo "oasis.sh <init/import/update/export/start/status/stop> [app]"
}

function debug {
    if [[ "$OASIS_DEBUG" == "true" ]];then
        echo "$@"
    fi
}

function msg {
    echo "$@"
}

if [[ "$action" == "" ]];then
    helpApp
    exit -1
fi

if [[ ! -f ./env.sh ]];then
    msg "Scripts should be run in the oasis directory."
    exit -1
fi

source ./env.sh

servicesIniFile=$OASIS_HOME/services.ini

function invoke {
    script=$1
    args="${@:2}"

    if [[ "$script" == "" ]];then
        msg "Script is required."
        exit -1
    fi

    if [[ -f $script ]];then
        $script $args

        if [[ $? -eq 0 ]];then
            debug "[$script] executed successfully with args [$args]."
            return 0
        else
            debug "[$script] executed abnormally with args [$args]."
            return -1
        fi
    else
        msg "[$script] does not exist and is hence skipped."
        return 0
    fi
}

function initApp {
    app=$1
    if [[ "$app" == "" ]];then
        while read p; do
            app=${p%=*}
            invoke $OASIS_HOME/controls/$app/init.sh $app
            msg "[$app] is initialized."
        done < $servicesIniFile
    else
        invoke $OASIS_HOME/controls/$app/init.sh $app
        msg "[$app] is initialized."
    fi
}

function importApp {
    app=$1
    if [[ "$app" == "" ]];then
        while read p; do
            app=${p%=*}
            invoke $OASIS_HOME/controls/$app/import.sh $app
            msg "[$app] is imported."
        done < $servicesIniFile
    else
        invoke $OASIS_HOME/controls/$app/import.sh $app
        msg "[$app] is imported."
    fi
}

function updateApp {
    app=$1
    if [[ "$app" == "" ]];then
        while read p; do
            app=${p%=*}
            invoke $OASIS_HOME/controls/$app/update.sh $app
            msg "[$app] is updated."
        done < $servicesIniFile
    else
        invoke $OASIS_HOME/controls/$app/update.sh $app
        msg "[$app] is updated."
    fi
}

function exportApp {
    app=$1
    if [[ "$app" == "" ]];then
        while read p; do
            app=${p%=*}
            invoke $OASIS_HOME/controls/$app/export.sh $app
            msg "[$app] is exported."
        done < $servicesIniFile
    else
        invoke $OASIS_HOME/controls/$app/export.sh $app
        msg "[$app] is exported."
    fi
}

function doStartApp {
    app=$1
    port=$2

    invoke $OASIS_HOME/controls/$app/status.sh $app $port
    if [[ $? -eq 0 ]];then
        msg "[$app] is already running at port [$port]."
    else
        invoke $OASIS_HOME/controls/$app/start.sh $app $port
        msg "[$app] is started."
    fi
}

function startApp {
    app=$1
    if [[ "$app" == "" ]];then
        while read p; do
            app=${p%=*}
            port=${p#*=}
            doStartApp $app $port
        done < $servicesIniFile
    else
        p=`cat $servicesIniFile | grep "$app="`
        port=${p#*=}
        doStartApp $app $port
    fi
}

function statusApp {
    app=$1
    if [[ "$app" == "" ]];then
        while read p; do
            app=${p%=*}
            port=${p#*=}
            invoke $OASIS_HOME/controls/$app/status.sh $app $port
            if [[ $? -eq 0 ]];then
                msg "[$app] is running at port [$port]."
            else
                msg "[$app] is not running."
            fi
        done < $servicesIniFile
    else
        p=`cat $servicesIniFile | grep "$app="`
        port=${p#*=}
        invoke $OASIS_HOME/controls/$app/status.sh $app $port
        if [[ $? -eq 0 ]];then
            msg "[$app] is running at port [$port]."
        else
            msg "[$app] is not running."
        fi
    fi
}

function doStopApp {
    app=$1
    port=$2

    invoke $OASIS_HOME/controls/$app/status.sh $app $port
    if [[ $? -eq 0 ]];then
        invoke $OASIS_HOME/controls/$app/stop.sh $app $port
        msg "[$app] is stopped."
    else
        msg "[$app] is not running."
    fi
}

function stopApp {
    app=$1
    if [[ "$app" == "" ]];then
        while read p; do
            app=${p%=*}
            port=${p#*=}
            doStopApp $app $port
        done < $servicesIniFile
    else
        p=`cat $servicesIniFile | grep "$app="`
        port=${p#*=}
        doStopApp $app $port
    fi
}

function validateEnv {
    depends=($OASIS_DEPENDS)
    for i in "${depends[@]}"; do
        if ! type $i > /dev/null 2>&1; then
            msg "[$i] should be installed."
            exit -1
        fi
    done
}

validateEnv

case "$action" in
    init)
        initApp "$target"
        ;;
    import)
        importApp "$target"
        ;;
    update)
        updateApp "$target"
        ;;
    export)
        exportApp "$target"
        ;;
    start)
        startApp "$target"
        ;;
    status)
        statusApp "$target"
        ;;
    stop)
        stopApp "$target"
        ;;
    *)
        helpApp
        ;;
esac
