#!/bin/bash
#Purpose: Automated & Highly Secure Setup for aws EKS cluster
#Maintainer: Muhammad Asim <quickbooks2018@gmail.com>

# Private Subnets
PRIVATE_SUBNET_1=`terraform output private-subnets-ids | sed -n 2p | cut -d'"' -f2`
PRIVATE_SUBNET_2=`terraform output private-subnets-ids | sed -n 3p | cut -d'"' -f2`
PRIVATE_SUBNET_3=`terraform output private-subnets-ids | sed -n 4p | cut -d'"' -f2`




PUBLIC_SUBNET_1=`terraform output public-subnet-ids | sed -n 2p | cut -d'"' -f2`
PUBLIC_SUBNET_2=`terraform output public-subnet-ids | sed -n 3p | cut -d'"' -f2`
PUBLIC_SUBNET_3=`terraform output public-subnet-ids | sed -n 4p | cut -d'"' -f2`




KEY_NAME="cloudgeeks-ca-eks"




# Creating a key pair for EC2 Workers Nodes

mkdir ~/.ssh 2>&1 >/dev/null

aws ec2 create-key-pair --key-name $KEY_NAME --query 'KeyMaterial' --output text > ~/.ssh/$KEY_NAME.pem


eksctl create cluster \
  --name cloudgeeks-ca-eks \
  --version 1.18 \
  --vpc-private-subnets=$PRIVATE_SUBNET_1,$PRIVATE_SUBNET_2,$PRIVATE_SUBNET_3 \
  --vpc-public-subnets=$PUBLIC_SUBNET_1,$PUBLIC_SUBNET_2,$PUBLIC_SUBNET_3 \
  --region us-east-1 \
  --node-private-networking \
  --nodegroup-name worker \
  --node-type t3a.medium \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 2 \
  --ssh-access \
  --node-volume-size 20 \
  --ssh-public-key $KEY_NAME \
  --alb-ingress-access \
  --managed \
  --asg-access \
  --verbose 3




# UPDATE YOUR ./kube
################################################################
### MUST ###
###---> aws eks update-kubeconfig --name cloudgeeks-ca-eks --region us-east-1 <---
##################################################################

#aws eks update-cluster-config \
#    --region us-east-1 \
#    --name cloudgeeks-ca-eks

# Update Public to Private End Points
###---> aws eks update-cluster-config --name cloudgeeks-ca-eks --region us-east-1 --resources-vpc-config endpointPublicAccess=false,endpointPrivateAccess=true
#END
