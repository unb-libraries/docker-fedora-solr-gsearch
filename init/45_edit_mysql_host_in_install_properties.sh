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
else
  sed -i "s/jdbc\:mysql\:\/\/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\:\d{2,4}\/.*\?/jdbc\:mysql\:\/\/$MYSQL_PORT_3306_TCP_ADDR\:$MYSQL_PORT_3306_TCP_PORT\/$FEDORA_MYSQL_DB\?/g" ${FEDORA_HOME}/server/config/fedora.fcfg
  sed -i "s/server=\"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\" port=\"\d{2,4}\" dbname=\".*\" user=\".*\" password=\".*\"/server\=\"$MYSQL_PORT_3306_TCP_ADDR\" port\=\"$MYSQL_PORT_3306_TCP_PORT\" dbname\=\"$DRUPAL_DB_NAME\" user\=\"$DRUPAL_DB_USER\" password\=\"$DRUPAL_DB_PASSWORD\"/g" ${FEDORA_HOME}/server/config/filter-drupal.xml
fi

