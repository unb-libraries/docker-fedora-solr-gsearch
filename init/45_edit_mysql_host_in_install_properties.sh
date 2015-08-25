#!/usr/bin/env bash

# Do in-place edits of MySQL address
sed -i "s/MYSQL_HOST/$MYSQL_PORT_3306_TCP_ADDR/g" ${TMP_WORKDIR}/install.properties
sed -i "s/MYSQL_PORT/$MYSQL_PORT_3306_TCP_PORT/g" ${TMP_WORKDIR}/install.properties
