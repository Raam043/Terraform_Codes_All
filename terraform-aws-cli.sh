#!/bin/bash
#OS:Amazon-Linux+Ubuntu
#Prerequisite:Do Not Attach an IAM Role, use YOUR Account Progmatic Secret Key & Access Key
#Owner: Muhammad Asim ---> quickbooks2018@gmail.com



# Terraform Setup

apt update -y && apt install -y curl
curl -# -LO https://releases.hashicorp.com/terraform/0.12.16/terraform_0.12.16_linux_amd64.zip
apt update -y && apt install -y unzip 2>&1 >/dev/null
unzip terraform_0.12.16_linux_amd64.zip
rm -rf *.zip
cp terraform /usr/bin/
cp terraform /usr/local/bin
rm -rf terraform



# Install AWS Cli

apt update -y
apt  install awscli  -y
apt install python3-pip -y
pip3 install --upgrade --user awscli
