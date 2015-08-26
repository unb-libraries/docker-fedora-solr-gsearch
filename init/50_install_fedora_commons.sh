#!/usr/bin/env bash

if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  java -jar ${TMP_WORKDIR}/fcrepo-installer-${FEDORA_VERSION}.jar ${TMP_WORKDIR}/install.properties
  rm -rf ${TMP_WORKDIR}/fcrepo-installer-${FEDORA_VERSION}.jar
fi
