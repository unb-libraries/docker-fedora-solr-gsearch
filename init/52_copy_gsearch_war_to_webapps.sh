#!/usr/bin/env bash

if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  mv ${TMP_WORKDIR}/fedoragsearch-2.8/fedoragsearch.war ${FEDORA_HOME}/tomcat/webapps/
fi
