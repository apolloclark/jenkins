# Jenkins - Pipeline

Demo of the Jenkins Pipeline plugin, using Vagrant to run an Ubuntu 14.04 LTS
64-bit instance, locally using Virtualbox, or remotely using Amazon. It will
pull down and use whatever the latest Jenkins Stable build is.

![alt text](https://github.com/apolloclark/vagrant-jenkins-pipeline/blob/master/preview.jpg "Jenkins Pipeline preview")

## Run Locally
```shell
git clone https://github.com/apolloclark/vagrant-jenkins-pipeline
cd vagrant-jenkins-pipeline
cp -f aws-config-example.yml aws-config.yml
vagrant up
# open a browser: http://127.0.0.1:8080/job/PipelineDemo/
# click "Build Now"
```

## Run on Amazon
```shell
git clone https://github.com/apolloclark/vagrant-jenkins-pipeline
cd vagrant-jenkins-pipeline
cp -f aws-config-example.yml aws-config.yml
# update aws-config.yml with AWS credentials
vagrant up --provider=aws
# open a browser: http://<ec2_ip_addr>:8080/job/Python_Pipeline/
# click "Build Now"


# create SSH port forwarding tunnel
ssh -L 8080:127.0.0.1:8080 admin@<ec2-dns> -i <aws_key_file>

# create SSH port forwarding tunnel without a Terminal
ssh -nNT -L 8080:127.0.0.1:8080 admin@<ec2-dns> -i <aws_key_file>
```

## Jenkins Logs
```shell
watch tail -n 32 /var/log/jenkins/jenkins.log
```

## Painite attacks
```shell
# scan the local network
nmap -sn -vv 172.17.0.1/24

# TCP SYN port scan a specific IP
nmap -sS -vv 172.17.0.2

# attempt to connect
curl -i  http://172.17.0.2:8008/1677330664470980985/ | less

# list all the DIRB wordlists
ls -lah /usr/share/dirb/wordlists/
ls -lah /usr/share/dirb/wordlists/others
ls -lah /usr/share/dirb/wordlists/vulns

# run the dirb attack, filter out responses that are 250 bytes
dirb http://172.17.0.2:8008/1677330664470980985/ \
    /usr/share/dirb/wordlists/common.txt -f \
    | grep -v 250


```




## Configure for Programming Language

There are multiple sub-projects within the ./data folder, which are Quickstarts
for various programming languages and web frameworks. You can edit the
Vagrantfile to install language specific code quality tools, and enable
language specific Build projects.

## Links

- https://wiki.jenkins-ci.org/display/JENKINS/Pipeline+Plugin
- https://dzone.com/refcardz/continuous-delivery-with-jenkins-workflow
- https://documentation.cloudbees.com/docs/cookbook/pipeline-as-code.html
- http://udaypal.com/jenkins-workflow-getting-started/
- https://www.cloudbees.com/blog/parallelism-and-distributed-builds-jenkins
<br/>

- https://github.com/jenkinsci/pipeline-examples/tree/master/pipeline-examples
- https://github.com/jenkinsci/workflow-aggregator-plugin/blob/master/demo/plugins.txt
- https://github.com/jenkinsci/pipeline-plugin/blob/master/COMPATIBILITY.md
<br/>

- https://wiki.jenkins-ci.org/display/JENKINS/Plugin+tutorial
<br/>

- http://www.slideshare.net/cloudbees/pimp-your-continuous-delivery-pipeline-with-jenkins-workflow-wjax-14/20

