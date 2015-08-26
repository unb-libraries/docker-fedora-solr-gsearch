#!/usr/bin/env bash

if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  sed -i -e "s|#fgsindex.uriResolver|fgsindex.uriResolver|g" ${FEDORA_HOME}/tomcat/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/index.properties
fi
