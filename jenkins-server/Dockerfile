FROM apolloclark/jenkins-base
MAINTAINER Apollo Clark apolloclark@gmail.com 

# Describe the environment
ENV DEBIAN_FRONTEND "noninteractive"

# copy over the config and jobs
COPY ./data/jenkins /root/jenkins
RUN chmod +x /vagrant/bootstrap_copy_project.sh; \
	sync; \
	/vagrant/bootstrap_copy_project.sh
    
EXPOSE 8080

CMD service jenkins start && tail -F /var/log/jenkins/jenkins.log
