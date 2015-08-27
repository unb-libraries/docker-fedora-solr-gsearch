#!/usr/bin/env bash

# Check if this is the initial deployment.
if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  # Modify Stock XACML Policies to those reccomended by Islandora install wiki.
  rm -v ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/default/deny-purge-*
  # rm -v ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/islandora/permit-apim-to-anonymous-user.xml
  # rm -v ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/islandora/permit-upload-to-anonymous-user.xml

  # Add in Islandora specific policies.
  cp -r ${TMP_WORKDIR}/islandora-xacml-policies ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/islandora

  # Allow API-M access from Docker Mask IP in addition to localhost.
  sed -i '35i            <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:regexp-string-match">\n        <AttributeValue DataType="http://www.w3.org/2001/XMLSchema#string">172\\.17\\.\\d{1,3}\\.\\d{1,3}</AttributeValue>\n          <Apply FunctionId="urn:oasis:names:tc:xacml:1.0:function:string-one-and-only">\n            <EnvironmentAttributeDesignator AttributeId="urn:fedora:names:fedora:2.1:environment:httpRequest:clientIpAddress" DataType="http://www.w3.org/2001/XMLSchema#string"/>\n          </Apply>\n          </Apply>' ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/default/deny-apim-if-not-localhost.xml

  # Install drupalauthfilter JAR in Fedora lib path.
  cp -v ${TMP_WORKDIR}/fcrepo-drupalauthfilter-${FEDORA_AUTH_FILTER_FEDORA_VERSION}.jar ${FEDORA_HOME}/tomcat/webapps/fedora/WEB-INF/lib
fi
