#!/usr/bin/env bash

if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  sed -i -e "s|FEDORA_HOME_DIR|$FEDORA_HOME|g" ${TMP_WORKDIR}/fgsconfig-basic.properties
  cp ${TMP_WORKDIR}/fgsconfig-basic.properties ${FEDORA_HOME}/tomcat/webapps/fedoragsearch/FgsConfig
fi
