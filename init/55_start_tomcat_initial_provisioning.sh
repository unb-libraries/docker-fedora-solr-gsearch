#!/usr/bin/env bash

if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  ${FEDORA_HOME}/tomcat/bin/startup.sh
fi
