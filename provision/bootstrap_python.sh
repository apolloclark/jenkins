#!/bin/bash

# Install various dependencies
apt-get -y install build-essential libreadline-gplv2-dev libncursesw5-dev \
    libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev sshpass \
    git-core sloccount jmeter sqlite3 libsqlite3-dev



# Install Python
echo "INFO: Installing Python..."
apt-get -y install python2.7 python-pip python-dev libpq-dev libffi-dev \
	libssl-dev
pip install --upgrade pip > /dev/null 2>&1
# @see https://pip.pypa.io/en/latest/reference/pip.html

# Install code quality tools
pip install -qqq pylint > /dev/null
pip install --quiet mock coverage nose nosexcover clonedigger ndg-httpsclient \
	pyasn1 > /dev/null 2>&1

# Install Flask requirements
pip install -qqq -r /vagrant/jobs/Python_Pipeline/requirements.txt > /dev/null 2>&1
echo "INFO: Done installing Python."

# create folder for SQLite DB
mkdir -p /tmp/tmp
touch /tmp/tmp/sample.db
chown www-data:www-data /tmp/tmp/sample.db
chown www-data:www-data /tmp/tmp
chmod -R 777 /tmp/tmp





# Install Jenkins plugins
# @see http://updates.jenkins-ci.org/download/plugins/
# @see /var/lib/jenkins/plugins/
echo "INFO: Installing Jenkins plugins..."
mkdir -p /var/lib/jenkins/plugins/
chown -R jenkins:jenkins /var/lib/jenkins/plugins
/vagrant/jenkins_install_plugins.sh /vagrant/jenkins_plugins_python.txt
chown -R jenkins:jenkins /var/lib/jenkins/plugins

# clear the logs, set folder permissions, restart
rm -f /var/log/jenkins/jenkins.log
echo "INFO: Done installing Jenkins plugins."



# copy over project setup
cp -r /vagrant/jobs/Python_Pipeline /var/lib/jenkins/jobs/
chmod -R 777 /var/lib/jenkins/jobs/

# restart Jenkins
service jenkins restart
