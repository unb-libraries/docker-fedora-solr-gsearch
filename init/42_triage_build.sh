#!/usr/bin/env bash

# Here, we default to using the address from a linked container named 'mysql', falling back to using the
# details provided through MYSQL_HOSTNAME and MYSQL_PORT environment variables.
MYSQL_PORT_3306_TCP_ADDR="${MYSQL_PORT_3306_TCP_ADDR:-$(echo $FEDORA_MYSQL_HOST)}"
MYSQL_PORT_3306_TCP_PORT="${MYSQL_PORT_3306_TCP_PORT:-$(echo $FEDORA_MYSQL_PORT)}"

# Remove old file markers to eliminate false positives
rm -rf /tmp/FEDORA_DB_LIVE
rm -rf /tmp/FEDORA_FILES_LIVE
rm -rf /tmp/FEDORA_NEEDS_INSTALL

# Check if the Fedora database has been populated with data.
RESULT=`mysqlshow -h ${MYSQL_PORT_3306_TCP_ADDR} -P ${MYSQL_PORT_3306_TCP_PORT} --user=${FEDORA_MYSQL_USER} --password=${FEDORA_MYSQL_PASS} ${FEDORA_MYSQL_DB} | grep -o pidGen`
if [ "$RESULT" == "pidGen" ];
then
  touch /tmp/FEDORA_DB_LIVE
  echo "Fedora DB Found!"
fi

# Determine if the site was previously built by checking for a deny-apim-if-not-localhost.xml file.
if [ -f "${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/default/deny-apim-if-not-localhost.xml" ];
then
  touch /tmp/FEDORA_FILES_LIVE
  echo "Fedora Files Found!"
fi

# Create a convenience marker to use later.
if [[ ! -f /tmp/FEDORA_DB_LIVE && ! -f /tmp/FEDORA_FILES_LIVE ]];
then
  touch /tmp/FEDORA_NEEDS_INSTALL
fi
