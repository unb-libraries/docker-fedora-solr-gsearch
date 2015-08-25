#!/usr/bin/env bash

sed -i -e "s|#fgsindex.uriResolver|fgsindex.uriResolver|g" ${FEDORA_HOME}/tomcat/webapps/fedoragsearch/WEB-INF/classes/fgsconfigFinal/index/FgsIndex/index.properties
