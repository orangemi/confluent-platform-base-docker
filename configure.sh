#!/usr/bin/env bash
set -e
for VAR in `env`
do
  if [[ $VAR =~ ^CONNECT_ ]]; then
    connect_name=`echo "$VAR" | sed -r "s/CONNECT_(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]' | tr _ .`
    env_var=`echo "$VAR" | sed -r "s/(.*)=.*/\1/g"`
    if egrep -q "(^|^#)$connect_name=" $CONNECT_HOME/etc/worker.properties; then
      sed -r -i "s@(^|^#)($connect_name)=(.*)@\2=${!env_var}@g" $CONNECT_HOME/etc/worker.properties #note that no config values may contain an '@' char
    else
      echo "$connect_name=${!env_var}" >> $CONNECT_HOME/etc/worker.properties
    fi
  fi
done

