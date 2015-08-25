#!/usr/bin/env bash

# Add Drupal Auth Filter to jaas.conf
sed -i "5i    ca.upei.roblib.fedora.servletfilter.DrupalAuthModule required" ${FEDORA_HOME}/server/config/jaas.conf
sed -i "6i    debug=true;" ${FEDORA_HOME}/server/config/jaas.conf
