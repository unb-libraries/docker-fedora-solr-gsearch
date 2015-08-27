#!/usr/bin/env bash

# Check if this is the initial deployment.
if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  ${FEDORA_HOME}/tomcat/bin/startup.sh
fi
