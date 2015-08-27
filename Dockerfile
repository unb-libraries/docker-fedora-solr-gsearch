FROM unblibraries/jdk:oracle8
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

## Environment Variables
# Versions
ENV JAVA_MAJOR_VERSION=8
ENV FEDORA_VERSION=3.8.1
ENV FEDORA_AUTH_FILTER_VERSION=7.1.3
ENV FEDORA_AUTH_FILTER_FEDORA_VERSION=3.8.0
ENV GSEARCH_VERSION=2.8
ENV GSEARCH_DGI_EXTENSION_VERSION=0.1.1
ENV SOLR_VERSION=4.2.0

ENV FEDORA_MYSQL_USER fedora
ENV FEDORA_MYSQL_PASS fedora
ENV FEDORA_MYSQL_DB fedora3
ENV FEDORA_MYSQL_HOST 127.0.0.1
ENV FEDORA_MYSQL_PORT 3006

# Paths
ENV TMP_WORKDIR=/tmp/islandora_install
ENV SOLR_DIR=/opt/solr
ENV FEDORA_HOME=/usr/local/fedora
ENV CATALINA_HOME=/usr/local/fedora/tomcat
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_MAJOR_VERSION}-oracle
ENV JRE_HOME=/usr/lib/jvm/java-${JAVA_MAJOR_VERSION}-oracle/jre
ENV KAKADU_LIBRARY_PATH=/usr/local/djatoka/lib/Linux-x86-64

# Download URIs
ENV FEDORA_COMMONS_DL_URI=http://downloads.sourceforge.net/project/fedora-commons/fedora/${FEDORA_VERSION}/fcrepo-installer-${FEDORA_VERSION}.jar
ENV FEDORA_DRUPAL_FILTER_DL_URI=https://github.com/Islandora/islandora_drupal_filter/releases/download/v${FEDORA_AUTH_FILTER_VERSION}/fcrepo-drupalauthfilter-${FEDORA_AUTH_FILTER_FEDORA_VERSION}.jar
ENV FEDORA_DRUPAL_FILTER_XML_DL_URI=https://raw.githubusercontent.com/Islandora/islandora_drupal_filter/master/filter-drupal.xml
ENV GSEARCH_DL_URI=http://downloads.sourceforge.net/project/fedora-commons/services/3.7/fedoragsearch-${GSEARCH_VERSION}.zip
ENV GSEARCH_DGI_EXT_DL_URI=https://github.com/discoverygarden/dgi_gsearch_extensions/releases/download/v${GSEARCH_DGI_EXTENSION_VERSION}/gsearch_extensions-${GSEARCH_DGI_EXTENSION_VERSION}-jar-with-dependencies.jar
ENV SOLR_DL_URI=http://archive.apache.org/dist/lucene/solr/${SOLR_VERSION}/solr-${SOLR_VERSION}.tgz
ENV SOLR_DGI_SCHEMA_DL_URI=https://raw.githubusercontent.com/discoverygarden/basic-solr-config/modular/conf/schema.xml

# Other
ENV JAVA_OPTS="-Xms1024m -Xmx1024m -XX:MaxPermSize=128m -Djavax.net.ssl.trustStore=${FEDORA_HOME}/server/truststore -Djavax.net.ssl.trustStorePassword=tomcat"

## Build Image.
# Install prerequisite packages.
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y git ant unzip mysql-client

RUN mkdir -p ${TMP_WORKDIR}

# Install and configure Fedora.
RUN wget --directory-prefix=${TMP_WORKDIR}/ ${FEDORA_COMMONS_DL_URI}
ADD conf/fedora-commons/install.properties ${TMP_WORKDIR}/install.properties

RUN wget --directory-prefix=${TMP_WORKDIR}/ ${FEDORA_DRUPAL_FILTER_DL_URI}
RUN wget --directory-prefix=${TMP_WORKDIR}/ ${FEDORA_DRUPAL_FILTER_XML_DL_URI}
RUN git clone git://github.com/mjordan/drupal_filter_validator ${TMP_WORKDIR}/drupal_filter_validator
RUN git clone git://github.com/Islandora/islandora-xacml-policies.git ${TMP_WORKDIR}/islandora-xacml-policies

# Install and configure GSearch.
RUN wget --directory-prefix=${TMP_WORKDIR}/ ${GSEARCH_DL_URI}
RUN cd ${TMP_WORKDIR} && unzip fedoragsearch-${GSEARCH_VERSION}.zip
RUN wget --directory-prefix=${TMP_WORKDIR}/ ${GSEARCH_DGI_EXT_DL_URI}
RUN git clone git://github.com/discoverygarden/basic-solr-config.git ${TMP_WORKDIR}/basic-solr-config
ADD conf/gsearch/fgsconfig-basic.properties ${TMP_WORKDIR}/fgsconfig-basic.properties

# Install and configure Solr.
RUN wget --directory-prefix=${TMP_WORKDIR}/ ${SOLR_DL_URI}
RUN cd ${TMP_WORKDIR}/ && tar xvzpf solr-${SOLR_VERSION}.tgz
RUN mv ${TMP_WORKDIR}/solr-${SOLR_VERSION} /opt/
RUN ln -s ${SOLR_DIR}-${SOLR_VERSION} ${SOLR_DIR}
ADD conf/solr/solr.xml ${TMP_WORKDIR}/solr.xml
RUN sed -i -e "s|SOLR_VERSION|$SOLR_VERSION|g" ${TMP_WORKDIR}/solr.xml

RUN wget --directory-prefix=${TMP_WORKDIR}/ ${SOLR_DGI_SCHEMA_DL_URI}
RUN sed -i 's|<filter class="solr.EnglishPorterFilterFactory" protected="protwords.txt"/>|<filter class="solr.SnowballPorterFilterFactory" language="English" protected="protwords.txt"/>|g' ${TMP_WORKDIR}/schema.xml
RUN sed -i '290i   <field name="_version_" type="long" indexed="true" stored="true"/>' ${TMP_WORKDIR}/schema.xml
RUN mv ${TMP_WORKDIR}/schema.xml ${SOLR_DIR}/example/solr/collection1/conf

RUN sed -i 's|<openSearcher>false</openSearcher>|<openSearcher>true</openSearcher>|g' ${SOLR_DIR}/example/solr/collection1/conf/solrconfig.xml
RUN sed -i 's|<queryResultWindowSize>20</queryResultWindowSize>|<queryResultWindowSize>50</queryResultWindowSize>|g' ${SOLR_DIR}/example/solr/collection1/conf/solrconfig.xml
RUN sed -i 's|<requestDispatcher handleSelect="false" >|<requestDispatcher handleSelect="true" >|g' ${SOLR_DIR}/example/solr/collection1/conf/solrconfig.xml
RUN sed -i '782i       <str name="fl">*</str>' ${SOLR_DIR}/example/solr/collection1/conf/solrconfig.xml
RUN sed -i '783i       <str name="q.alt">*:*</str>' ${SOLR_DIR}/example/solr/collection1/conf/solrconfig.xml
RUN sed -i '784i       <str name="qf">dc.title^5 dc.subject^3 dc.description^3 dc.creator^3 dc.contributor^3 dc.type^1 dc.relation^1 dc.publisher^1 mods_identifier_local_ms^3 ds.WARC_FILTER^1 text_nodes_HOCR_hlt^1 mods_subject_hierarchicalGeographic_region_ms^3 mods_identifier_hdl_mt^3 dc.identifier^3 PID^0.5 catch_all_fields_mt^0.1</str>' ${SOLR_DIR}/example/solr/collection1/conf/solrconfig.xml

CMD ["/sbin/my_init"]

# Copy phusion/baseimage inits.
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh

# Clean-up
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/solr-* /var/tmp/*

EXPOSE 8080
