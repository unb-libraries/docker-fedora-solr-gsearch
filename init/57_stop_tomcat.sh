#!/usr/bin/env bash

# Check if this is the initial deployment.
if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  killall -9 java
  rm -rf "${FEDORA_HOME}/tomcat/webapps/ROOT/init.txt"
fi
