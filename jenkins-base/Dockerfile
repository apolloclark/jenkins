FROM ubuntu:14.04 
MAINTAINER Apollo Clark apolloclark@gmail.com 

# Describe the environment
ENV DEBIAN_FRONTEND "noninteractive"
ENV JDK_VERSION 1.8.0_111
ENV JENKINS_VERSION 2.32.1

# install Jenkins
COPY ./provision /vagrant
RUN chmod +x /vagrant/bootstrap.sh; \
	sync; \
    /vagrant/bootstrap.sh

RUN chmod +x /vagrant/bootstrap_python.sh; \
	sync; \
	/vagrant/bootstrap_python.sh
    
EXPOSE 8080
