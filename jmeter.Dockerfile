FROM openjdk:16-alpine

WORKDIR /home


#!/bin/bash
# from https://gist.github.com/smithbr/f2f19d7c362ef17530aaa7ccfaefeb06
#
ENV JMETER_VERSION=5.2.1
ENV CMDRUNNER_VERSION=2.2
ENV JMETER_HOME=/home/apache-jmeter-${JMETER_VERSION}
ENV PATH=${PATH}:/home/apache-jmeter-${JMETER_VERSION}/bin

RUN set -ex \
  # Install/unzip jmeter, plugin manager & plugins 
  && wget "http://mirror.ibcp.fr/pub/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz" -O /dev/shm/apache-jmeter-${JMETER_VERSION}.tgz \
  && tar xzf /dev/shm/apache-jmeter-${JMETER_VERSION}.tgz \
  # && mv /dev/shm/apache-jmeter-${JMETER_VERSION} . \
  && wget "https://jmeter-plugins.org/get/" -O ${JMETER_HOME}/lib/ext/plugins-manager.jar \
  && wget "http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar" -O ${JMETER_HOME}/lib/cmdrunner-${CMDRUNNER_VERSION}.jar \
  ;

COPY config/ ./config

RUN set -ex \
  && java -cp ${JMETER_HOME}/lib/ext/plugins-manager.jar org.jmeterplugins.repository.PluginManagerCMDInstaller \
  && PluginsManagerCMD.sh install-for-jmx ./config/test-plan.jmx \
  && PluginsManagerCMD.sh install jmeter.backendlistener.elasticsearch \
  ;

CMD jmeter
