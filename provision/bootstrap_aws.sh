#!/bin/bash

# set the environment to be fully automated
export DEBIAN_FRONTEND="noninteractive"

# Autoresize the EC2 root EBS partition, if needed
if [[ $(df -h | grep 'xvda1') ]]; then
    /sbin/parted ---pretend-input-tty /dev/xvda resizepart 1 yes 100%
    resize2fs /dev/xvda1
fi