#!/bin/bash

# set the environment to be fully automated
export DEBIAN_FRONTEND="noninteractive"



# Install Jenkins
# @see https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | \
	apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" | \
	sudo tee /etc/apt/sources.list.d/jenkins.list
add-apt-repository -y ppa:openjdk-r/ppa 2>&1
apt-get -y update
apt-get install -y openjdk-8-jre-headless daemon git-core jenkins

# hackish way to install a specific version of Jenkins
# dpkg --install /vagrant/jenkins_1.642_all.deb
service jenkins restart



# Install Jenkins plugins
# @see http://updates.jenkins-ci.org/download/plugins/
# @see /var/lib/jenkins/plugins/
# @see https://github.com/jenkinsci/workflow-aggregator-plugin/blob/master/demo/plugins.txt

# install the Jenkins plugins
echo "INFO: Installing Jenkins plugins..."
mkdir -p /var/lib/jenkins/plugins/
chmod -R 0777 /var/lib/jenkins/plugins
/vagrant/jenkins_install_plugins.sh /vagrant/jenkins_plugins.txt
service jenkins restart

# clear the logs, set folder permissions, restart
chmod -R 0777 /var/lib/jenkins/plugins
rm -f /var/log/jenkins/jenkins.log
service jenkins restart
echo "INFO: Done installing Jenkins plugins."



# copy over project setup
echo "INFO: Copying over Pre-configured Jobs."
mkdir -p /var/lib/jenkins/jobs/
cp -rf /vagrant/jobs/. /var/lib/jenkins/jobs/
chmod -R 777 /var/lib/jenkins/jobs/
chown -R jenkins:jenkins /var/lib/jenkins

# restart Jenkins
cp -f /vagrant/config.xml /var/lib/jenkins/config.xml
service jenkins restart

exit 0;



# install Docker
apt-get install apt-transport-https ca-certificates
apt-key adv \
    --keyserver hkp://ha.pool.sks-keyservers.net:80 \
    --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | \
	sudo tee /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y \
	linux-headers-generic \
	linux-image-extra-$(uname -r) \
    linux-image-extra-virtual \
    linux-image-generic-lts-trusty \
    docker-engine
usermod -aG docker vagrant
service docker start
docker run hello-world 2>&1

# download the Painite and Gruyere containers
# docker pull apolloclark/painite | cat
docker load --input /vagrant/painite.tar -q

# docker pull karthequian/gruyere | cat
docker load --input /vagrant/gruyere.tar -q
	