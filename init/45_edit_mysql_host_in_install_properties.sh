#!/usr/bin/env bash

if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  MYSQL_PORT_3306_TCP_ADDR="${MYSQL_PORT_3306_TCP_ADDR:-$(echo $FEDORA_MYSQL_HOST)}"
  MYSQL_PORT_3306_TCP_PORT="${MYSQL_PORT_3306_TCP_PORT:-$(echo $FEDORA_MYSQL_PORT)}"

  # Do in-place edits of MySQL properties
  sed -i "s/FEDORA_MYSQL_HOST/$MYSQL_PORT_3306_TCP_ADDR/g" ${TMP_WORKDIR}/install.properties
  sed -i "s/FEDORA_MYSQL_PORT/$MYSQL_PORT_3306_TCP_PORT/g" ${TMP_WORKDIR}/install.properties
  sed -i "s/FEDORA_MYSQL_USER/$FEDORA_MYSQL_USER/g" ${TMP_WORKDIR}/install.properties
  sed -i "s/FEDORA_MYSQL_PASS/$FEDORA_MYSQL_PASS/g" ${TMP_WORKDIR}/install.properties
  sed -i "s/FEDORA_MYSQL_DB/$FEDORA_MYSQL_DB/g" ${TMP_WORKDIR}/install.properties
fi
