#!/usr/bin/env bash

if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  cp ${TMP_WORKDIR}/basic-solr-config/foxmlToSolr.xslt ${FEDORA_HOME}/tomcat/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/
  cp -r ${TMP_WORKDIR}/basic-solr-config/islandora_transforms ${FEDORA_HOME}/tomcat/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/
fi
