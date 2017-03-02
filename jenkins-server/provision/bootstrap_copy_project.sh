#!/bin/bash

# set the environment to be fully automated
export DEBIAN_FRONTEND="noninteractive"

# copy over project setup
echo "INFO: Copying over Pre-configured Jobs."
mkdir -p /var/lib/jenkins/jobs/
cp -rf /root/jenkins/. /var/lib/jenkins/
chmod -R 777 /var/lib/jenkins/jobs/
chown -R jenkins:jenkins /var/lib/jenkins

# print the generated password
echo -e "Jenkins Password:"
cat /var/lib/jenkins/secrets/initialAdminPassword
