#!/usr/bin/env bash

# Wait for tomcat to finish app deployment.
while [[ ! -f "${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/default/deny-apim-if-not-localhost.xml" || ! -f "${FEDORA_HOME}/tomcat/webapps/fedoragsearch/WEB-INF/lib/lib.properties" ]]
do
  echo -e "\t Sleeping to wait for Tomcat to finish app deployment..."
  sleep 5
done
