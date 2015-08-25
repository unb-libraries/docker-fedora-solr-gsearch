#!/usr/bin/env bash

cd ${FEDORA_HOME}/tomcat/webapps/fedoragsearch/FgsConfig
ant generateIndexingXslt
ant -f fgsconfig-basic.xml
