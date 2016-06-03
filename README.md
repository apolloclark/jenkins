# Jenkins - Pipeline

Demo of the Jenkins Pipeline plugin, using Vagrant to run an Ubuntu 14.04 LTS
64-bit instance, locally using Virtualbox, or remotely using Amazon. It will
pull down and use whatever the latest Jenkins Stable build is.

## Run Locally
```shell
git clone https://github.com/apolloclark/vagrant-jenkins-pipeline
cd vagrant-jenkins-pipeline
vagrant up
# open a browser: http://127.0.0.1:8080/job/PipelineDemo/
```

## Run on Amazon
```shell
git clone https://github.com/apolloclark/vagrant-jenkins-pipeline
cd vagrant-jenkins-pipeline
cp aws-config-example.yml aws-config.yml
# update aws-config.yml with AWS credentials
vagrant up --provider=aws
# open a browser: http://<ec2_ip_addr>:8080/
```

## Jenkins Logs
```shell
watch tail -n 32 /var/log/jenkins/jenkins.log
```

## Configure for Language

There are multiple sub-projects within this one which are Quickstarts for
various programming languages and web frameworks. You can edit the Vagrantfile
to install language specific code quality tools, and enable language specific
Build projects.

## Links

https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin
https://dzone.com/refcardz/continuous-delivery-with-jenkins-workflow
https://documentation.cloudbees.com/docs/cookbook/pipeline-as-code.html
http://udaypal.com/jenkins-workflow-getting-started/
https://www.cloudbees.com/blog/parallelism-and-distributed-builds-jenkins

https://github.com/jenkinsci/pipeline-examples/tree/master/pipeline-examples
https://github.com/jenkinsci/workflow-aggregator-plugin/blob/master/demo/plugins.txt
https://github.com/jenkinsci/pipeline-plugin/blob/master/COMPATIBILITY.md

https://wiki.jenkins-ci.org/display/JENKINS/Plugin+tutorial

http://www.slideshare.net/cloudbees/pimp-your-continuous-delivery-pipeline-with-jenkins-workflow-wjax-14/20

