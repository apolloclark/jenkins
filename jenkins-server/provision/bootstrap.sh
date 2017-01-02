#!/bin/bash

# set the environment to be fully automated
export DEBIAN_FRONTEND="noninteractive"

# update system
apt-get update
apt-get upgrade -y
apt-get install -y wget curl unzip unzip wget daemon python-setuptools \
	software-properties-common git-core ca-certificates





# Install OpenJDK 8

# Sets language to UTF8 : this works in pretty much all cases
locale-gen en_US.UTF-8

# add repo, update, install
add-apt-repository -y ppa:openjdk-r/ppa 2>&1
apt-get update
apt-get install -y openjdk-8-jre-headless
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"





# Install Jenkins
# @see https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu
wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | \
	apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian-stable binary/" | \
	sudo tee /etc/apt/sources.list.d/jenkins.list
add-apt-repository -y ppa:openjdk-r/ppa 2>&1
apt-get update
apt-get install -y jenkins

# hackish way to install a specific version of Jenkins
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
# service jenkins restart

# clear the logs, set folder permissions, restart
chmod -R 0777 /var/lib/jenkins/plugins
rm -f /var/log/jenkins/jenkins.log
# service jenkins restart
echo "INFO: Done installing Jenkins plugins."



# copy over project setup
echo "INFO: Copying over Pre-configured Jobs."
mkdir -p /var/lib/jenkins/jobs/
cp -rf /vagrant/jenkins/jobs/. /var/lib/jenkins/jobs/
chmod -R 777 /var/lib/jenkins/jobs/
chown -R jenkins:jenkins /var/lib/jenkins

# restart Jenkins
cp -f /vagrant/jenkins/config.xml /var/lib/jenkins/config.xml
# service jenkins restart

exit 0;



# dismiss the security challenge
curl --silent --request POST 'http://localhost/Service' \
	--data-urlencode "path=/xyz/pqr/test/" \
	--data-urlencode "fileName=1.doc"
# Jenkins-Crumb=9df2be68aa0c9fa7dc8d4d3985c8651c&json=%7B%22Jenkins-Crumb%22%3A+%229df2be68aa0c9fa7dc8d4d3985c8651c%22%7D&no=Dismiss
POST /administrativeMonitor/jenkins.diagnostics.SecurityIsOffMonitor/act HTTP/1.1
Host: 127.0.0.1:8080
Connection: keep-alive
Content-Length: 130
Cache-Control: max-age=0
Origin: http://127.0.0.1:8080
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36
Content-Type: application/x-www-form-urlencoded
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
DNT: 1
Referer: http://127.0.0.1:8080/
Accept-Encoding: gzip, deflate, br
Accept-Language: en-US,en;q=0.8
Cookie: JSESSIONID.beab5237=ei6u7dwuuioy9dha12k274nc; screenResolution=1920x1080


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
	