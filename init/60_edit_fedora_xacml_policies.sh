#!/usr/bin/env bash

# Modify Stock XACML Policies
rm -v ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/default/deny-purge-*
# rm -v ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/islandora/permit-apim-to-anonymous-user.xml
# rm -v ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/islandora/permit-upload-to-anonymous-user.xml

# Add in Islandora specific policies
cp -r ${TMP_WORKDIR}/islandora-xacml-policies ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/islandora

# Allow access from Drupal site
sed -i -e "s|<AttributeValue DataType=\"http://www.w3.org/2001/XMLSchema#string\">127.0.0.1</AttributeValue>|<AttributeValue DataType=\"http://www.w3.org/2001/XMLSchema#string\">127.0.0.1</AttributeValue>\n           <AttributeValue DataType=\"http://www.w3.org/2001/XMLSchema#string\">${DRUPAL_PORT_80_TCP_ADDR}</AttributeValue>|g" ${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/default/deny-apim-if-not-localhost.xml

# Install auth filter in Fedora lib
cp -v ${TMP_WORKDIR}/fcrepo-drupalauthfilter-${FEDORA_AUTH_FILTER_FEDORA_VERSION}.jar ${FEDORA_HOME}/tomcat/webapps/fedora/WEB-INF/lib
