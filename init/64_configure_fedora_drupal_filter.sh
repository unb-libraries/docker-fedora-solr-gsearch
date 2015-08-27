#!/usr/bin/env bash

# Here, we default to using the address from a linked container named 'mysql', falling back to using the
# details provided through MYSQL_HOSTNAME and MYSQL_PORT environment variables.
MYSQL_PORT_3306_TCP_ADDR="${MYSQL_PORT_3306_TCP_ADDR:-$(echo $FEDORA_MYSQL_HOST)}"
MYSQL_PORT_3306_TCP_PORT="${MYSQL_PORT_3306_TCP_PORT:-$(echo $FEDORA_MYSQL_PORT)}"

# Check if this is the initial deployment.
if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  # Drupal Auth Filter deployment and config
  cp ${TMP_WORKDIR}/filter-drupal.xml $FEDORA_HOME/server/config/filter-drupal.xml
  sed -i -e "s|DB_SERVER|$MYSQL_PORT_3306_TCP_ADDR|g" $FEDORA_HOME/server/config/filter-drupal.xml
  sed -i -e "s|DRUPAL_DB_NAME|$DRUPAL_DB_NAME|g" $FEDORA_HOME/server/config/filter-drupal.xml
  sed -i -e "s|DRUPAL_DB_USER|$DRUPAL_DB_USER|g" $FEDORA_HOME/server/config/filter-drupal.xml
  sed -i -e "s|DRUPAL_DB_PASS|$DRUPAL_DB_PASSWORD|g" $FEDORA_HOME/server/config/filter-drupal.xml
fi
