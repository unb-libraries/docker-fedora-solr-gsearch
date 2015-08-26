#!/usr/bin/env bash

if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  cd ${FEDORA_HOME}/tomcat/webapps/fedoragsearch/FgsConfig
  ant generateIndexingXslt
  ant -f fgsconfig-basic.xml
fi
