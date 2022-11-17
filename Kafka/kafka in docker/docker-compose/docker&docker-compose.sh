#!/bin/bash
# Purpose: Installation of docker & docker-compose
# OS: AmazonLinux


# Docker Installation
yum install -y docker
systemctl start docker
systemctl enable docker

# Docker Compose Installation

curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker-compose --version











# END