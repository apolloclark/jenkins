#!/bin/bash

# set the environment to be fully automated
export DEBIAN_FRONTEND="noninteractive"

# update system
apt-get update
apt-get upgrade -y
apt-get install -y wget curl unzip unzip wget daemon python-setuptools \
	software-properties-common git-core





# Install OpenJDK 8

# Sets language to UTF8 : this works in pretty much all cases
locale-gen en_US.UTF-8

# add repo, update, install
add-apt-repository -y ppa:openjdk-r/ppa 2>&1
apt-get update
apt-get install -y openjdk-8-jre-headless
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
apt-get install -y ca-certificates
/var/lib/dpkg/info/ca-certificates-java.postinst configure





# Install Jenkins
# @see https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | \
	apt-key add -
echo "deb https://pkg.jenkins.io/debian binary/" | \
	sudo tee /etc/apt/sources.list.d/jenkins.list
add-apt-repository -y ppa:openjdk-r/ppa 2>&1
apt-get update
apt-get install -y jenkins

# install a specific version of Jenkins
# dpkg --install /vagrant/jenkins_1.642_all.deb
# service jenkins restart



# Install Jenkins plugins
# @see http://updates.jenkins-ci.org/download/plugins/
# @see /var/lib/jenkins/plugins/
# @see https://github.com/jenkinsci/workflow-aggregator-plugin/blob/master/demo/plugins.txt

# install the Jenkins plugins
echo "INFO: Installing Jenkins plugins..."
mkdir -p /var/lib/jenkins/plugins/
chmod -R 0777 /var/lib/jenkins/plugins
/vagrant/jenkins_install_plugins.sh /vagrant/jenkins_plugins.txt

# clear the logs, set folder permissions, restart
chmod -R 0777 /var/lib/jenkins/plugins
rm -f /var/log/jenkins/jenkins.log
echo "INFO: Done installing Jenkins plugins."
