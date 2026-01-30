#!/bin/bash
# Set hostname
hostnamectl set-hostname ${hostname}

# Update system
yum update -y

# Install Docker (Amazon Linux 2 uses amazon-linux-extras)
# amazon-linux-extras install docker -y
yum install docker -y
# Start Docker service
systemctl enable docker
systemctl start docker

# Print environment variable
echo "Environment: ${env}" >> /etc/motd