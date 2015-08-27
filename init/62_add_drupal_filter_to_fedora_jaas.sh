#!/usr/bin/env bash

# Check if this is the initial deployment.
if [ -f /tmp/FEDORA_NEEDS_INSTALL ];
then
  # Add Drupal Auth Filter to jaas.conf
  sed -i "5i    ca.upei.roblib.fedora.servletfilter.DrupalAuthModule required" ${FEDORA_HOME}/server/config/jaas.conf
  sed -i "6i    debug=true;" ${FEDORA_HOME}/server/config/jaas.conf
fi
