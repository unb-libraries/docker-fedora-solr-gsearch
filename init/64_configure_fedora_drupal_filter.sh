#!/usr/bin/env bash

# Filter config
cp ${TMP_WORKDIR}/filter-drupal.xml $FEDORA_HOME/server/config/filter-drupal.xml
sed -i -e "s|DB_SERVER|$MYSQL_PORT_3306_TCP_ADDR|g" $FEDORA_HOME/server/config/filter-drupal.xml
sed -i -e "s|DRUPAL_DB_NAME|$DRUPAL_DB_NAME|g" $FEDORA_HOME/server/config/filter-drupal.xml
sed -i -e "s|DRUPAL_DB_USER|$DRUPAL_DB_USER|g" $FEDORA_HOME/server/config/filter-drupal.xml
sed -i -e "s|DRUPAL_DB_PASS|$DRUPAL_DB_PASSWORD|g" $FEDORA_HOME/server/config/filter-drupal.xml