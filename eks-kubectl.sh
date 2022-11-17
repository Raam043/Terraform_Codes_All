#!/bin/bash
#OS:Amazon-Linux+Ubuntu
#Prerequisite:Do Not Attach an IAM Role, use YOUR Account Progmatic Secret Key & Access Key
#Owner: Muhammad Asim ---> quickbooks2018@gmail.com



# Terraform Setup Ubuntu

apt update -y && apt install -y curl 2>&1 >/dev/null
curl -# -LO https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
apt update -y && apt install -y unzip 2>&1 >/dev/null
unzip terraform_0.12.16_linux_amd64.zip 2>&1 >/dev/null
rm -rf *.zip  2>&1 >/dev/null
cp terraform /usr/bin/  2>&1 >/dev/null
cp terraform /usr/local/bin  2>&1 >/dev/null
rm -rf terraform


# Terraform Setup AmazonLinux

curl -# -LO https://releases.hashicorp.com/terraform/0.14.7/terraform_0.14.7_linux_amd64.zip
unzip terraform_0.14.7_linux_amd64.zip
rm -rf *.zip  2>&1 >/dev/null
cp terraform /usr/bin/  2>&1 >/dev/null
rm -rf terraform



# Install AWS Cli

apt update -y  2>&1 >/dev/null
apt  install awscli  -y   2>&1 >/dev/null
apt install python3-pip -y   2>&1 >/dev/null
pip3 install --upgrade --user awscli  2>&1 >/dev/null


yum update -y && yum install -y awscli 2>&1 >/dev/null




# Kubectl Installation
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl

mv ./kubectl /usr/bin/kubectl





# IAM authenticator
# Installing AWS IAM authenticator ---> (This allows us to administor our EKS Clustor, using our IAM Identity)

# https://github.com/kubernetes-sigs/aws-iam-authenticator

# We are using the AWS Version of IAM authenticator ---> https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html


# Download the Amazon EKS-vended aws-iam-authenticator binary from Amazon S3
# curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator



curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator


chmod +x ./aws-iam-authenticator

mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH

cp ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator && export PATH=$HOME/usr/local/bin:$PATH

echo 'export PATH=$HOME/usr/local/bin:$PATH' >> ~/.bashrc

rm -rf aws-iam-authenticator

# aws-iam-authenticator help


# END
