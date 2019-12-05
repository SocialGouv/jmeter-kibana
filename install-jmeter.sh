#!/bin/bash
# from https://gist.github.com/smithbr/f2f19d7c362ef17530aaa7ccfaefeb06
#
JMETER_VERSION=5.2.1
CMDRUNNER_VERSION=2.2

# Download & unzip
curl http://mirror.ibcp.fr/pub/apache//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz > ./apache-jmeter-${JMETER_VERSION}.tgz
tar -xzf $HOME/apache-jmeter-${JMETER_VERSION}.tgz 

# Create a .env file
echo "export JMETER_HOME=$(pwd)/apache-jmeter-${JMETER_VERSION}" > .jmeter.env
echo 'export PATH=$PATH:$JMETER_HOME/bin' >> .jmeter.env
source .jmeter.env

# Install jmeter plugin manager & plugins
curl -L "https://jmeter-plugins.org/get/" > ${JMETER_HOME}/lib/ext/plugins-manager.jar
curl -L "http://search.maven.org/remotecontent?filepath=kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar" > ${JMETER_HOME}/lib/cmdrunner-${CMDRUNNER_VERSION}.jar
java -cp ${JMETER_HOME}/lib/ext/plugins-manager.jar org.jmeterplugins.repository.PluginManagerCMDInstaller
PluginsManagerCMD.sh install-for-jmx ./test-plan.jmx
PluginsManagerCMD.sh install jmeter.backendlistener.elasticsearch