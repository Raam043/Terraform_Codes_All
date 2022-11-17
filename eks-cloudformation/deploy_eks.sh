#!/bin/bash
# Purpose: Automated & Highly Secure Setup for aws EKS cluster
# Maintainer: Muhammad Asim


# EKS 
StackName="cloudgeeksca-cluster-eks"
Region="us-east-1"
EksCluster="$StackName"
eks_version="1.19"
nodegroup_name="worker"
node_type="t3a.medium"
deploy_nodes="2"
deploy_nodes_min="2"
deploy_nodes_max="5"
node_volume_size="50"

export Region
export AWS_DEFAULT_REGION=${Region}
# Private Subnets
PrivSubnetAz1=`aws ec2 describe-subnets --region "${Region}" --filters Name=tag:Private-Subnet-AZ1,Values="${EksCluster}-Private-Subnet-AZ1" | head -n1 | cut -f13`
PrivSubnetAz2=`aws ec2 describe-subnets --region "${Region}" --filters Name=tag:Private-Subnet-AZ2,Values="${EksCluster}-Private-Subnet-AZ2" | head -n1 | cut -f13`
PrivSubnetAz3=`aws ec2 describe-subnets --region "${Region}" --filters Name=tag:Private-Subnet-AZ3,Values="${EksCluster}-Private-Subnet-AZ3" | head -n1 | cut -f13`




PubSubnetAz1=`aws ec2 describe-subnets --region "${Region}" --filters Name=tag:Public-Subnet-AZ1,Values="${EksCluster}-Public-Subnet-AZ1" | head -n1 | cut -f13`
PubSubnetAz2=`aws ec2 describe-subnets --region "${Region}" --filters Name=tag:Public-Subnet-AZ1,Values="${EksCluster}-Public-Subnet-AZ1" | head -n1 | cut -f13`
PubSubnetAz3=`aws ec2 describe-subnets --region "${Region}" --filters Name=tag:Public-Subnet-AZ3,Values="${EksCluster}-Public-Subnet-AZ3" | head -n1 | cut -f13`



KEY_NAME="cloudgeeksca-eks"




# Creating a key pair for EC2 Workers Nodes

mkdir ~/.ssh 2>&1 >/dev/null

aws ec2 create-key-pair --key-name $KEY_NAME --query 'KeyMaterial' --output text > ~/.ssh/$KEY_NAME.pem

export AWS_DEFAULT_REGION=${Region}

# Eks Cluster SetUp

eksctl create cluster \
  --name ${EksCluster} \
  --version ${eks_version} \
  --vpc-private-subnets=$PrivSubnetAz1,$PrivSubnetAz2,$PrivSubnetAz3 \
  --vpc-public-subnets=$PubSubnetAz1,$PubSubnetAz2,$PubSubnetAz3 \
  --region ${Region} \
  --node-private-networking \
  --nodegroup-name ${nodegroup_name} \
  --node-type ${node_type} \
  --nodes ${deploy_nodes} \
  --nodes-min ${deploy_nodes_min} \
  --nodes-max ${deploy_nodes_max} \
  --ssh-access \
  --node-volume-size ${node_volume_size} \
  --ssh-public-key ${KEY_NAME} \
  --appmesh-access \
  --full-ecr-access \
  --alb-ingress-access \
  --managed \
  --asg-access \
  --verbose 3




# UPDATE YOUR ./kube
################################################################
### MUST ###
###---> aws eks update-kubeconfig --name cloudgeeksca-eks --region us-east-1 <---
##################################################################

# Update Public to Private End Points
###---> aws eks update-cluster-config --name cloudgeeksca-eks --region us-east-1 --resources-vpc-config endpointPublicAccess=false,endpointPrivateAccess=true
#END
