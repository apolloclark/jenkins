#!/bin/bash

# Update Aptitude
apt-get update



# Install Jenkins
# @see https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | \
	apt-key add -
sh -c 'echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list'
apt-get -y update
apt-get install -y openjdk-7-jre-headless daemon git-core jenkins

# hackish way to install a specific version of Jenkins
# dpkg --install /vagrant/jenkins_1.642_all.deb
service jenkins restart



# Install Jenkins plugins
# @see http://updates.jenkins-ci.org/download/plugins/
# @see /var/lib/jenkins/plugins/
echo "INFO: Installing Jenkins plugins..."
mkdir -p /var/lib/jenkins/plugins/
chmod -R 0777 /var/lib/jenkins/plugins

/vagrant/jenkins_install_plugins.sh /vagrant/jenkins_plugins.txt
service jenkins restart

# clear the logs, set folder permissions, restart
chmod -R 0777 /var/lib/jenkins/plugins
rm -f /var/log/jenkins/jenkins.log
cp /vagrant/config.xml /var/lib/jenkins/config.xml
service jenkins restart
echo "INFO: Done installing Jenkins plugins."



# copy over project setup
echo "INFO: Copying over Pre-configured Jobs."
mkdir -p /var/lib/jenkins/jobs/
cp -r /vagrant/jobs/PipelineDemo /var/lib/jenkins/jobs/
chmod -R 777 /var/lib/jenkins/jobs/

# restart Jenkins
service jenkins restart

# Autoresize the EC2 root EBS partition, if needed
if [[ $(df -h | grep 'xvda1') ]]; then
    sudo /sbin/parted ---pretend-input-tty /dev/xvda resizepart 1 yes 100%
    sudo resize2fs /dev/xvda1
fi
