#!/bin/bash

# Update Aptitude
sudo apt-get update
export DEBIAN_FRONTEND="noninteractive"



# Install Jenkins
# @see https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | \
	sudo apt-key add -
sudo sh -c 'echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get -y update
sudo apt-get install -y openjdk-8-jre-headless daemon git-core jenkins

# hackish way to install a specific version of Jenkins
# dpkg --install /vagrant/jenkins_1.642_all.deb
sudo service jenkins restart



# Install Jenkins plugins
# @see http://updates.jenkins-ci.org/download/plugins/
# @see /var/lib/jenkins/plugins/
echo "INFO: Installing Jenkins plugins..."
sudo mkdir -p /var/lib/jenkins/plugins/
sudo chmod -R 0777 /var/lib/jenkins/plugins

/vagrant/jenkins_install_plugins.sh /vagrant/jenkins_plugins.txt
sudo service jenkins restart

# clear the logs, set folder permissions, restart
sudo chmod -R 0777 /var/lib/jenkins/plugins
sudo rm -f /var/log/jenkins/jenkins.log
sudo cp /vagrant/config.xml /var/lib/jenkins/config.xml
sudo service jenkins restart
echo "INFO: Done installing Jenkins plugins."



# copy over project setup
echo "INFO: Copying over Pre-configured Jobs."
sudo mkdir -p /var/lib/jenkins/jobs/
sudo cp -r /vagrant/jobs/PipelineDemo /var/lib/jenkins/jobs/
sudo chmod -R 777 /var/lib/jenkins/jobs/

# restart Jenkins
sudo service jenkins restart

# Autoresize the EC2 root EBS partition, if needed
if [[ $(df -h | grep 'xvda1') ]]; then
    sudo /sbin/parted ---pretend-input-tty /dev/xvda resizepart 1 yes 100%
    sudo resize2fs /dev/xvda1
fi
