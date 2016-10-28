#!/usr/bin/env bash
set -e
./configure.sh
CLASSPATH=/etc/jars/* bin/connect-distributed etc/worker.properties
