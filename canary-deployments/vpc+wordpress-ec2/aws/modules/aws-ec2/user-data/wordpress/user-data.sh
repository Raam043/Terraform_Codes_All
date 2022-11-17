#!/bin/bash
#Purpose: LAMP Stack
#App: Wordpress
#OS AmazonLinux/Ubuntu
#Maintainer DevOps Muhammad Asim <quickbooks2018@gmail.com>

# Docker Installation
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh      2>&1 > /dev/null
rm -rf get-docker.sh
yum install -y docker 2>&1 > /dev/null
systemctl start docker
systemctl enable docker

# Docker Compose Installation

curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

NETWORK=`docker network ls | awk '{print $2}' | grep -i "cloudgeeks.ca"`
if [ "0" == "$?" ]
then
  echo -e "\n Hey! docker network "$NETWORK" exists \n"
  else
    docker network create cloudgeeks.ca
    fi

# Mariadb Setup
docker volume create mariadb
docker run --name mariadb -e MARIADB_DATABASE=bitnami_wordpress -e MARIADB_ROOT_PASSWORD="ausdermoitoeuropas" -v mariadb:/bitnami --network="cloudgeeks.ca" --restart unless-stopped -d bitnami/mariadb:latest

# Phpmyadmin Setup
docker run --name phpmyadmin --network="cloudgeeks.ca" --link mariadb:db -id -p 8080:80 --restart unless-stopped phpmyadmin/phpmyadmin


# Wordpress Setup
docker volume create wordpress
docker run --name bitnami-wordpress --network="cloudgeeks.ca" -e WORDPRESS_DATABASE_NAME="bitnami_wordpress" -e WORDPRESS_DATABASE_USER="root" -e WORDPRESS_DATABASE_PASSWORD="ausdermoitoeuropas" --link mariadb:db  -v wordpress:/bitnami --restart unless-stopped -p 80:8080 -d bitnami/wordpress:latest





#END
