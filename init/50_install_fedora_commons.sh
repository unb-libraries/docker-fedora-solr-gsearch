#!/usr/bin/env bash

# Check if this is the initial deployment.
if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  # Install fedora-commons
  java -jar ${TMP_WORKDIR}/fcrepo-installer-${FEDORA_VERSION}.jar ${TMP_WORKDIR}/install.properties
  rm -rf ${TMP_WORKDIR}/fcrepo-installer-${FEDORA_VERSION}.jar
fi
