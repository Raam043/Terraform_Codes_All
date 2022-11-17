#!/bin/bash
#OS:Amazon-Linux+Ubuntu
#Prerequisite:Do Not Attach an IAM Role, use YOUR Account Progmatic Secret Key & Access Key
#Owner: Muhammad Asim ---> quickbooks2018@gmail.com



# Terraform Setup

apt update -y && apt install -y curl 2>&1 >/dev/null
curl -# -LO https://releases.hashicorp.com/terraform/0.12.21/terraform_0.12.21_linux_amd64.zip
apt update -y && apt install -y unzip 2>&1 >/dev/null
unzip terraform_0.12.16_linux_amd64.zip 2>&1 >/dev/null
rm -rf *.zip  2>&1 >/dev/null
cp terraform /usr/bin/  2>&1 >/dev/null
cp terraform /usr/local/bin  2>&1 >/dev/null
rm -rf terraform

# helm 
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -f get_helm.sh

# Install AWS Cli

apt update -y  2>&1 >/dev/null
apt  install awscli  -y   2>&1 >/dev/null
apt install python3-pip -y   2>&1 >/dev/null
pip3 install --upgrade --user awscli  2>&1 >/dev/null


yum update -y && yum install -y awscli 2>&1 >/dev/null


# EKSCTL AmazonLinux
# https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html
# 1. Download and extract the latest release of eksctl with the following command.
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

# 2. Move the extracted binary to /usr/bin

mv /tmp/eksctl /usr/bin

# 3. Test that your installation was successful with the following command.
eksctl version

# Kubectl Installation
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl

mv ./kubectl /usr/bin/kubectl


# EKSCTL Installation

# https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version




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
