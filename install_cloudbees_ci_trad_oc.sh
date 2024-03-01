#!/bin/bash

# Author: Makafui Awuku
# Date Created: 01/03/2024
# Date Modified: 01/03/2024

# Description
# Install Cloudbees CI operaton center on linux

# Usage
# Run command with no variables

#Set version of the operations center.
export CBCI_OC_VERSION=2.361.2.1-1.1
export CBCI_OC_VERSION_SHORT=$(echo $CBCI_OC_VERSION | cut -c 1,3-4)

# Updating packages
yum update -y

# Check for daemonize dependency and install. 
if [ $(($CBCI_OC_VERSION_SHORT)) -lt 242 ] 
then
    echo "daemonize needed. Installing it now"
    yum install epel-release -y 
    yum install daemonize -y
fi

yum install java-11-openjdk -y
yum install wget -y
wget -c https://downloads.cloudbees.com/cloudbees-core/traditional/operations-center/rolling/rpm/RPMS/noarch/cloudbees-core-oc-$CBCI_OC_VERSION.noarch.rpm
rpm -ivh cloudbees-core-oc-$CBCI_OC_VERSION.noarch.rpm
systemctl enable cloudbees-core-oc
systemctl start cloudbees-core-oc

exit 0
