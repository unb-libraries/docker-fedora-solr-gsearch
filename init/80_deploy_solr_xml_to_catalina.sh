#!/usr/bin/env bash

if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  cp ${TMP_WORKDIR}/solr.xml ${FEDORA_HOME}/tomcat/conf/Catalina/localhost/
fi
