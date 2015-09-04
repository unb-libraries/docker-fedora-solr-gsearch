#!/usr/bin/env bash

# Check if this is the initial deployment.
if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then

  # Wait for ROOT to deploy to drop in init.txt marker
  while [[ ! -f "${FEDORA_HOME}/tomcat/webapps/ROOT/RELEASE-NOTES.txt" ]]
  do
    echo -e "\t Sleeping to wait for Tomcat to finish ROOT app deployment..."
    sleep 5
  done

  echo "INIT" > "${FEDORA_HOME}/tomcat/webapps/ROOT/init.txt"

  # Wait for tomcat to finish the initial app deployment from the first startup.
  while [[ ! -f "${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/default/deny-apim-if-not-localhost.xml" || ! -f "${FEDORA_HOME}/tomcat/webapps/fedoragsearch/WEB-INF/lib/lib.properties" ]]
  do
    echo -e "\t Sleeping to wait for Tomcat to finish fedora/fedoragsearch app deployment..."
    sleep 5
  done
fi
