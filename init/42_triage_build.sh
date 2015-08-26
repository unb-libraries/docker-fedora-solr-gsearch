#!/usr/bin/env bash

MYSQL_PORT_3306_TCP_ADDR="${MYSQL_PORT_3306_TCP_ADDR:-$(echo $FEDORA_MYSQL_HOST)}"
MYSQL_PORT_3306_TCP_PORT="${MYSQL_PORT_3306_TCP_PORT:-$(echo $FEDORA_MYSQL_PORT)}"

# Triage request
rm -rf /tmp/FEDORA_DB_LIVE
rm -rf /tmp/FEDORA_FILES_LIVE
rm -rf /tmp/FEDORA_NEEDS_INSTALL

echo "mysqlshow -h ${MYSQL_PORT_3306_TCP_ADDR} -P ${MYSQL_PORT_3306_TCP_PORT} --user=${FEDORA_MYSQL_USER} --password=${FEDORA_MYSQL_PASS} ${FEDORA_MYSQL_DB} | grep -o datastreamPaths"
RESULT=`mysqlshow -h ${MYSQL_PORT_3306_TCP_ADDR} -P ${MYSQL_PORT_3306_TCP_PORT} --user=${FEDORA_MYSQL_USER} --password=${FEDORA_MYSQL_PASS} ${FEDORA_MYSQL_DB} | grep -o pidGen`
echo "***$RESULT***"
if [ "$RESULT" == "pidGen" ];
then
  touch /tmp/FEDORA_DB_LIVE
  echo "Fedora DB Found!"
fi

if [ -f "${FEDORA_HOME}/data/fedora-xacml-policies/repository-policies/default/deny-apim-if-not-localhost.xml" ];
then
  touch /tmp/FEDORA_FILES_LIVE
  echo "Fedora Files Found!"
fi

if [[ ! -f /tmp/FEDORA_DB_LIVE && ! -f /tmp/FEDORA_FILES_LIVE ]];
then
  touch /tmp/FEDORA_NEEDS_INSTALL
fi