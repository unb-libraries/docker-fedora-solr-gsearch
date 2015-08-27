#!/usr/bin/env bash

# Check if this is the initial deployment.
if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  cp ${TMP_WORKDIR}/gsearch_extensions-${GSEARCH_DGI_EXTENSION_VERSION}-jar-with-dependencies.jar ${FEDORA_HOME}/tomcat/webapps/fedoragsearch/WEB-INF/lib
fi
